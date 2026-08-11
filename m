Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54555446BF8;
	Tue, 11 Aug 2026 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457948; cv=none; b=YL+MUvoHgUI3v/hn6z4K1y25nB5GG7lVBQt36l9cWqBE+LNpnSGnAFyWIuaZFNERIh65bwxSY8xH8rDb1G5qmuRpMAvbZwGtYoWThTX1X5afT0BAgoFbHB3ljMnnYFZe2rUV25jYsSfT578gDd8fV8XjMzlfkzhy/n61LHBLdTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457948; c=relaxed/simple;
	bh=xJKETKNqMpSUttHHjrqgWyFLQVUsNdqR+BDgWzvC6CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgw2Siq1X6Ue/Z7WoQ59mpYTNGEyuXRpeizdew6zPx6jFGh2XxZVy0XtwQw6UnX+MLUwqH5ZE/51f0VbN0z5oP5QvL89/elWR1gJmPtF1Q71BtnF6od/fhvOy3sUdk3JUZaEoqfYVH9QYCQ1C2O7XBTRYTTvKrsNG3E3n7KOS7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpW0vvU4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpW0vvU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395D21F000E9;
	Tue, 11 Aug 2026 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786457947;
	bh=VQrgKP+AHdNa6o4dxOWobZCNZyfClv4mco8oJTpUOac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZpW0vvU4/b805wK9v0IRP1UAp7D7UAo4vkNAvTnK6eFpzrj5xV4rwva60fQg2JqKV
	 j86JtusU5/qfh89Ui0O9mzgq3ccpB1s9r5D9x3Y0PT16YxaFhjrru7S0AstaqXj8K6
	 kL7GvWhPsx5wZ1Fz5jBl+Ru0lAhzpbp/IJic9uPqij/1sQw9QwHJMVYGwTkQeFQeVP
	 0YZ7DS9MLbutcrPXiyFAN1Sr9tNyAQcP86I+Z5+vrNtZjnPyHclAXNayuVpytJ+6Rc
	 /3Rq5pYHiA7wN+G6OelfB7HSxhn4Jcb9MbwXxxfbDyV68XyYzOUUmX2+ZvzO4RocGs
	 7xmMkrhyib2nw==
Message-ID: <2022e782-099f-4b93-9968-30931a46101d@kernel.org>
Date: Tue, 11 Aug 2026 09:19:05 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/amd_node: Remove smn_exclusive
Content-Language: en-US
To: Yazen Ghannam <yazen.ghannam@amd.com>,
 Jason Andryuk <jason.andryuk@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Penny Zheng <penny.zheng@amd.com>, stable@vger.kernel.org
References: <20260806160159.230453-1-jason.andryuk@amd.com>
 <20260806160159.230453-2-jason.andryuk@amd.com>
 <20260810140747.GB57095@yaz-khff2.amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260810140747.GB57095@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/10/26 09:07, Yazen Ghannam wrote:
> On Thu, Aug 06, 2026 at 12:01:56PM -0400, Jason Andryuk wrote:
>> amd_smn_read/write() are exported functions around __amd_smn_rw(), so
>> they are always available even if amd_smn_init() fails.  smn_exclusive
>> would prevent access __amd_smn_rw(), but it is placed too late.  If
>> amd_smn_init() failed, amd_roots is NULL and __amd_smn_rw() will fault
>> over it.  Replace smn_exclusive with directly checking amd_roots to
>> avoid the NULL pointer dereference.
>>
>> Fixes: 77466b798d59 ("x86/amd_node: Remove dependency on AMD_NB")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
>> ---
>> Fixes is the introduction of amd_roots
>> ---
>>   arch/x86/kernel/amd_node.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
>> index 0be01725a2a4..ea553267e5fa 100644
>> --- a/arch/x86/kernel/amd_node.c
>> +++ b/arch/x86/kernel/amd_node.c
>> @@ -38,7 +38,6 @@ static struct pci_dev **amd_roots;
>>   
>>   /* Protect the PCI config register pairs used for SMN. */
>>   static DEFINE_MUTEX(smn_mutex);
>> -static bool smn_exclusive;
>>   
>>   #define SMN_INDEX_OFFSET	0x60
>>   #define SMN_DATA_OFFSET		0x64
>> @@ -91,11 +90,11 @@ static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, b
>>   	if (node >= amd_num_nodes())
>>   		return err;
>>   
>> -	root = amd_roots[node];
>> -	if (!root)
>> +	if (!amd_roots)
>>   		return err;
>>   
>> -	if (!smn_exclusive)
>> +	root = amd_roots[node];
>> +	if (!root)
>>   		return err;
>>   
>>   	guard(mutex)(&smn_mutex);
>> @@ -308,8 +307,6 @@ static int __init amd_smn_init(void)
>>   		debugfs_create_file("value",	0600, debugfs_dir, NULL, &smn_value_fops);
>>   	}
>>   
>> -	smn_exclusive = true;
>> -
>>   	return 0;
>>   }
>>   
> 
> 'smn_exclusive' wasn't originally intended to be used for bounds
> checking the array. But the original use is no longer needed, so it can
> be removed.
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Thanks,
> Yazen

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
