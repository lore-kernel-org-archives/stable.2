Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095647;
	b=V2tw2rv0h7jQsg14jBpDu7Ykmjflp0wZefr3TdWNTGte+0Fm+j23049n3tNUnt0BH/We
	 aWpk8ITjgr6pdEVRSn8QAE2LUpj7BY648Otm/rN60KGRCAAFn9yFhLOWpNS9m/NFgXABg
	 VmQVrcxVbJI/K3//b9tQnnsUwrRip38pmbSUcyLX+738vbdmiFHWUmvragFQdxK5eVgRH
	 y8s9OplxT1p3eVy3xN8LqgLZBpvdxAvyuIIMAMgzTOqMsbIiC6hPJnp7iibbHPexdvOh/
	 pahLyVDM6PAjd3FHcvZ7iykdV+ILkX15/AFeqTMeBocyBz6J7f8+CLIkx/wBLqrCRQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095647;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=fSot5EilqCYTXnvq8kQw3/OaKHnMrWXVOOIBWUnaAS8=;
	b=af/d+Ao+/gHAwe7sRhWy8Y9IbHD7wFen2AHUyMW+N8vv3Gf+dL54LzqwOVSSTGAiX7ZJ
	 f91UCsIlygU/3UBzTFJ9UAkafHi53anAGhmhFwqHhUZOP5EOMJZtJ0GIkFFPgbaugyaro
	 yt0X3naqWwvuWFV6xYp6ENGeiSEXl+9d5502CpycvSt6PmJOHdm3bLwyunobZqaUoSknI
	 AIDPhvgK7P13t5mNWDrDkI+gy2dP4TGNV/Z+mcdBHtz0MF9+P89ejemwQPbHZmoVhL//p
	 zyEjjXPPT1S98Bl2LYNLI9zVOve7bXhxX80+fSCHC30ioKHRFfUREFfz7AsMli4jhUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MyfAElSh;
	arc=none smtp.remote-ip=91.218.175.146
Received: from mta0.migadu.com (out-146.mta0.migadu.com [91.218.175.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53163606A322
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 10:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53163606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MyfAElSh
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EmC1viSKISOlO+4LV4Tq5yi5YtyJNhBL4pIRDOKg2QA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793095644; v=1; x=1793700444;
 b=MyfAElShe6jUrR9xnSoZrUkOVisggxknz1jRHruHD7OaBeWNHCrmn5Agq7SG26q26Tr6L7x8
 VFGQVVAOiWWOkyiqqAr/mhMfcaRatGKy++wTfxv6TU93eW/3jYNlSxdR1o7kqMOD2/C4xV9G6Bh
 1LclLypAw4qdUMABgq6H5rpc=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 275ac0127e5d04df;
	Tue, 27 Oct 2026 10:07:24 +0000
X-Mizu-Trace-ID: 275ac0127e5d04df
X-Migadu-Flow: FLOW_OUT
Message-ID: <0046bdae-1dd1-4f4b-a1e5-9eb7fe8b5fe0@linux.dev>
Date: Tue, 27 Oct 2026 11:07:19 +0100
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
Subject: Re: [PATCH] iomap: only follow dio alignment requirement if specified
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, da.gomez@kernel.org,
 gost.dev@samsung.com
References: <9fae60fcce5ae356deef5e38931124b9634dba3b.1792997261.git.wqu@suse.com>
 <at-p1QXETaTvvj_r@quentin> <5f49d819-12ec-48b2-b9b2-adce264d266d@gmx.com>
Content-Language: en-US
From: Pankaj Raghav <pankaj.raghav@linux.dev>
In-Reply-To: <5f49d819-12ec-48b2-b9b2-adce264d266d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/26/2026 9:59 PM, Qu Wenruo wrote:
> 
> 
> 在 2026/10/27 06:19, Pankaj Raghav (Samsung) 写道:
>> On Mon, Oct 26, 2026 at 05:18:13PM +1030, Qu Wenruo wrote:
>>>
>>> [CAUSE]
>>> The failed command of fsx is COPY_RANGE:
>>>
>>>   copy range: 0x6800 to 0xa200 at 0x3f200
>>>   do_copy_range:: Resource temporarily unavailable
>>>   LOG DUMP (8 total operations):
>>>   1(  1 mod 256): SKIPPED (no operation)
>>>   2(  2 mod 256): SKIPPED (no operation)
>>>   3(  3 mod 256): WRITE    0x14400 thru 0x211ff    (0xce00 bytes) HOLE
>>>   4(  4 mod 256): FALLOC   0x72bf4 thru 0x76221    (0x362d bytes) EXTENDING
>>>   5(  5 mod 256): SKIPPED (no operation)
>>>   6(  6 mod 256): INSERT 0x11000 thru 0x13fff    (0x3000 bytes)
>>>   7(  7 mod 256): TRUNCATE DOWN    from 0x79221 to 0xa800
>>>   8(  8 mod 256): COPY 0x6800 thru 0xa1ff    (0x3a00 bytes) to 0x3f200 thru 
>>> 0x42bff
>>>   Log of operations saved to "/mnt/test/junk.fsxops"; replay with --replay-ops
>>>   Correct content saved for comparison
>>>   (maybe hexdump "/mnt/test/junk" vs "/mnt/test/junk.fsxgood")
>>>
>>> Both ext4 and xfs only require direct IO to be aligned to the logical
>>> block size of the device, not the fs block size. So the 0x3a00 bytes
>>> read at 0x6800 is allowed, and should succeed.
>>>
>>> But that range is a hole, and that commit makes iomap_dio_hole_iter()
>>> round the zeroed length down to the fs block size unconditionally.
>>> The first iteration zeroes 0x3a00 bytes but only advances 0x3000 bytes,
>>> then the next iteration zeroes the remaining 0xa00 bytes, which is
>>> rounded down to 0, so -EFAULT is returned.
>>>
>>> As ext4 and xfs do not pass IOMAP_DIO_PARTIAL, the whole read fails
>>> with -EFAULT, which is then converted to -EAGAIN by copy_splice_read().
>>> Every retry of fsx hits the same -EAGAIN, failing the run.
>>>
>>> That commit breaks all direct reads which range is not fs block aligned
>>> for ext4 and xfs.
>>>
>>> [FIX]
>>> Do not revert the range unless the dio has IOMAP_DIO_FSBLOCK_ALIGNED flag.
>>>
>>> iomap_dio_hole_iter() is only called for reads, and for now only btrfs
>>> reads can reach this path with the flag set. Btrfs has the proper
>>> fallback when dio returns -EFAULT.
>>>
>>> Fixes: 4025185cf953 ("iomap: follow the alignment requirement for 
>>> iomap_dio_hole_iter()")
>>> Cc: stable@vger.kernel.org

FYI, your patches are not in 7.3 and only in linux-next. So we don't need to cc 
stable?
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/iomap/direct-io.c | 26 ++++++++++++++++----------
>>>   1 file changed, 16 insertions(+), 10 deletions(-)
>>>
>>
>> Ignore my previous question (I had a old version of xfstests).
>> I was able to reproduce the error on XFS, ext4 and this patch fixes it.
>>
>> One small nit: should we update the IOMAP_DIO_FSBLOCK_ALIGNED flag
>> documentation to reflect this?
>>
>> At the moment the document says "Ensure each bio is aligned to fs block
>> size". Should we expand it to say "Ensure each bio and any progress
>> reported for hole/unwritten extents is aligned to fs block size"?
> 
> I'll change it to something like "Ensure every operation, including bio and 
> folio zeroing, is aligned to fs block size".
>

This is better.
> Will be included in the next update.
> 

And for the b4 error, feel free to use:
Reviewed-by: Pankaj Raghav(Samsung) <pankaj.raghav@linux.dev>

--
Pankaj

