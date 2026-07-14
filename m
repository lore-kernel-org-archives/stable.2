Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40A3286D7D
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 05:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005402; cv=none; b=ILZcjyFENmWKUFwo/+pDdi99g77xXD96oNzkJev6NWG7naxIgAfUQE/QVRN1KRCdfRPJxNkD7fWbeSZVLeJq12xdOpkhk1woPikXjTSLl2rkfJ+sL0aXbTCRPuJ9dI6D86/weF4hi+WBtD4J57xGUEmp99VvEFSC173WjMl1/Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005402; c=relaxed/simple;
	bh=/e02zoCng2yy6jKUgkGJhTRqlBX8J/D+be0zaZ2j9+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpLRMlidqJ/5WiJVoBDrIBKWjh87pDrrDj//iK+SGiQcqspLdNAC2UQXX98HBRgJQeh9UK+1Idohd3Ni5ezCSckm5hSbib7uZrGdTibT0AseLDB+EfFp8wNXnjpOcd1X+W7Uy94zdkVbo2AbQLD94DV+A7UycAc6XxV4NSCaXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmoElVNx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmoElVNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DF71F00A3A;
	Tue, 14 Jul 2026 05:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784005400;
	bh=g8cF5BmjIbHYxIcsnaFNSFE3e9chFDivIMl8jnEVFV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MmoElVNxr44AF5mFtKrC8aBjBm22XiImwSWwv1uZxRfcJImRhW6ufOqWlrj/gIoJo
	 VZ4TH7snbAxxl8CDOAYwFyT9bLmitOHWBAtz8lA52nmrUlWQ+RteM182jyO/gtzjJj
	 0z4qdl6B/jX4g3+0J2KzZPIVOykH40FV3Wsgfj40ktsNhlZH55GQH33qfY9SuMRu3Y
	 m79uaam8ovm1JIFLPBFbnUWPwe+YNu2+7Kf7UsMpCqY0gIPNTV2W41kq1Oj0hqTdQv
	 syYym7SlJ6fr5S6ZgxiIdohPtZ8qv53tS00cydEk0DmKoaE5ZO10P1MvR+x0koYAKg
	 P/hpwfmu28Z4A==
Message-ID: <3ea09dad-9688-4f50-9939-059b8c6177fc@kernel.org>
Date: Tue, 14 Jul 2026 00:03:19 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] efivarfs: expose used and total size
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Anisse Astier <an.astier@criteo.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20260714043329.3510162-1-superm1@kernel.org>
 <2026071408-vividness-saga-4987@gregkh>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2026071408-vividness-saga-4987@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/13/26 11:58 PM, Greg KH wrote:
> On Mon, Jul 13, 2026 at 11:33:29PM -0500, Mario Limonciello (AMD) wrote:
>> From: Anisse Astier <an.astier@criteo.com>
>>
>> When writing EFI variables, one might get errors with no other message
>> on why it fails. Being able to see how much is used by EFI variables
>> helps analyzing such issues.
>>
>> Since this is not a conventional filesystem, block size is intentionally
>> set to 1 instead of PAGE_SIZE.
>>
>> x86 quirks of reserved size are taken into account; so that available
>> and free size can be different, further helping debugging space issues.
>>
>> With this patch, one can see the remaining space in EFI variable storage
>> via efivarfs, like this:
>>
>>     $ df -h /sys/firmware/efi/efivars/
>>     Filesystem      Size  Used Avail Use% Mounted on
>>     efivarfs        176K  106K   66K  62% /sys/firmware/efi/efivars
>>
>> Signed-off-by: Anisse Astier <an.astier@criteo.com>
>> [ardb: - rename efi_reserved_space() to efivar_reserved_space()
>>         - whitespace/coding style tweaks]
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> (cherry-picked from d86ff3333cb1 ("efivarfs: expose used and total size"))
>> Adjusted for headers in linux-6.1.y
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> Cc:Steve McIntyre <steve@einval.com>
>> Cc:Richard Hughes <richard@hughsie.com>
>>
>> Background for this backport is that fwupd needs to be able to do CA
>> updates on Debian oldstable (bookworm) which tracks 6.1.7.  The CA update
>> process checks for free storage, and needs this function to do it.
> 
> What is the git id of this commit?

Oh I mentioned it above between Ard's S-o-b and mine:

d86ff3333cb1 ("efivarfs: expose used and total size")
