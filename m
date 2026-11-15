Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707904;
	b=BmCOyqeuIVJPF7eaRmbqNHcGECs0Tr6xDBtNPkQxWyXhMus6ikD1nUvL2r0qnW1qcdSj
	 cXElzQU4x7c3X+B72nSgh/iVq8bcjdB7pg25ySVM0nspkEaY+AtZQL6y1vaL3BCOpFyXP
	 Zn2Z8RnS2ecSeCJTqGL288TgluSP2iSinunHabtpDGIsE/pnfUzPrfi5SBgbXHa2eu+EP
	 TdtlN7gSC3jorXDdpcszx9kFrSNVNVAdgh8oJnfCDbQ0AEKl64IyA3p6X5yRZCBiRAMLX
	 gKkrcS0qhup1q3zU0an5yI0yRcjM5Avd2k+5GCsydYeb1NmFpXVi7DcdU7nNcXSOu1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707904;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=t1NIFLAmVvQqYsF8K68iJnWNZPZlHSetWPUkvD5OZ8U=;
	b=CQAQBvSgmJs6gJZ68LKipPeT8Bl7TyR71Z+GIVf0k/hV774LN4+AYL00lt2i48eWq7XC
	 cOYXnbh4LdLTWL92yjNuqlocSB+a4yuE6bmrjEEOn50XvXm/jL309S3xjG3OfPCjIswMg
	 369gEJn0AuliSZmdZQ1Kut4AkIRF2kAcTNvJWPNACfPY5TYx9dFjiT/2+RTDRYHQ4Kn1N
	 Z/8g02XkXIjZB2OC1BM4xsyiT4jfTY3bkYqWVKte9KxEk3pJFWZqaOX0dW+UE5bxpK8x7
	 fveyonHLBSlc3Cu6+nBOVFdf69Axn7jkTxtEyqBn1KM79wvJzuVcX50YBytid2bSiOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmkCR1ym;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9552606A329;
	Sun, 15 Nov 2026 01:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmkCR1ym
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7743B1F000C4;
	Sun, 15 Nov 2026 01:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794707904;
	bh=t1NIFLAmVvQqYsF8K68iJnWNZPZlHSetWPUkvD5OZ8U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HmkCR1ymWVRtC167nqPrGcV7mnoJv1BG4NPCul8H5JxBfco+rxQP5h2EXe0PDPiVl
	 8mZn+FjfCtpLL7uHueUxsrzprcZyGn6A9DvgwbBMwEiUKPqrrjYpbURVyeX7WTfK1v
	 loiok76DXqCmwNSyBSyM4dRbPeubaMO9LEKsd2PyTCSoagWgpL/zSxO0y9Y63wzH0C
	 l4E7K2B7NL51m2hRxpWBRm649Cmk1OqSHaUxPabLcfbxNbcwPkazL5CFmtkAkDQPNd
	 oNku1Bfa45nmOhb7FMHTU9SOy5H/maob1cJjK2hgceiJZ1CWc5aC+gfTx7YdKqwe5S
	 smss0AugfKM4A==
Message-ID: <f72e653e-2cef-4920-89c3-f32ebc68de95@kernel.org>
Date: Sun, 15 Nov 2026 10:58:21 +0900
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: fix REQUESTED MAX LBA field for REMOVE
 ELEMENT AND TRUNCATE
To: Nick Spooner <nicholas.spooner@seagate.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@kernel.org>,
 "Martin K . Petersen" <mkp@kernel.org>, stable@vger.kernel.org
References: <20261113151929.9586-1-nicholas.spooner@seagate.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261113151929.9586-1-nicholas.spooner@seagate.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/26 00:19, Nick Spooner wrote:
> ata_scsi_remove_element_and_truncate_xlat() copies the REQUESTED CAPACITY
> field, req_capacity, to REQUESTED MAX LBA for every block count except 1.
> 
> However, SAT-6 specifies that if REQUESTED CAPACITY is greater than one,
> the REQUESTED MAX LBA shall be set to REQUESTED CAPACITY minus one, since
> the max LBA = count - 1 (see SAT-6 rev2, 9.16.1, Table 74). For example, if
> a capacity C > 1 is requested, the capacity ends up one block larger if the
> drive can provide C + 1. If the drive can provide C but not C + 1, a
> request that should be valid is instead rejected with INVALID FIELD IN CDB
> (see ACS-5 rev10, 7.33.3.3).
> 
> Modify ata_scsi_remove_element_and_truncate_xlat() to decrement
> req_capacity, except when equal to 1 or 0 (rejected if 1, let the device
> choose if 0).
> 
> Tested by issuing sg_rem_rest_elem on a Seagate drive ST32000NM001F,
> firmware db02 and checking the taskfile.
> 
> Fixes: db496721cb0d ("ata: libata-scsi: add support for the REMOVE ELEMENT AND TRUNCATE command")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nick Spooner <nicholas.spooner@seagate.com>

Good catch for the "- 1", but checking SAT, it says that:

If the REQUESTED CAPACITY field is set to one, then the REMOVE
ELEMENT AND TRUNCATE command shall be terminated with a
CHECK CONDITION status with the sense key set to ILLEGAL
REQUEST and the additional sense code set to INVALID FIELD IN
CDB.

So we should not silently ignore the 1 case and fail it.
Can you send a v2 with that failure added?

-- 
Damien Le Moal
Western Digital Research
