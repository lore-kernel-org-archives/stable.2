Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7501578F59;
	Sun, 21 Jun 2026 02:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782007307; cv=none; b=HKGMtGI3W/j8h6AeKKx3USPxbVB/zA1XHnnKagYm8HTnzaqDRxkIrHSMjMSU0liq/pzlu8ixX7kczTE9h4mMAzpkM2G47vtRkwWBGgWEa3X3o47Jrj1yuxQRE5XYq+fk4T73Lmx8HG6ogSxM0CwyY/2gsgH3qYAzsF3q9mERuEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782007307; c=relaxed/simple;
	bh=IG8s0ziE1yQkJWxxCfcPELA8jEth+tvSbd5/lyQPkOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYplFz2iGxFq8UbyahKOrwopjnxNC6yCsHbCe2suh+/+2yphpk59F5SV4uldKDt1O90ugy2+4MiAmMrPddsJnaC4HdmBFyU+k2evyQYZ7ohtGsKSla6FEJUaTdx9V9LKZ+z3ZLsF71zlHol09y28gldIMKvw91Ko3bl8Sh48qhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=l2WJ1m4K reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="l2WJ1m4K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=KSehoijHj
	KLAFNgMhcpRQlFttsdXLavDyC+04q9ZjeA=; b=l2WJ1m4KByDAt3171Ehf+Lsat
	ivEPDKv60ZPWVcVaUWhwXskfc3jrthTdnr1bZZQNIBWlV1FaxDMhga0W4I3KX+qF
	I9ViwRjyIZCGn+shLdvMByfu8Wd7k3al0SF4Lh6GKwO2ORpWE4M4+26jwR3p8b9w
	sD7CYbA9Cf/gxHnhNk=
Received: from [10.196.180.86] (unknown [113.200.174.80])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkB2mjT_RTdqenX5Ag--.46181S3;
	Sun, 21 Jun 2026 10:01:37 +0800 (CST)
Message-ID: <4a3fe921-77fb-4b5f-8403-43bb7ea40935@stu.xidian.edu.cn>
Date: Sun, 21 Jun 2026 10:01:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: i801: fix hardware state machine corruption in
 error path
To: Andi Shyti <andi.shyti@kernel.org>, jdelvare@suse.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, w15303746062@163.com
References: <20260512093534.348655-1-w15303746062@163.com>
 <aicfiAEdlbGmKIAU@zenone.zhora.eu>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <aicfiAEdlbGmKIAU@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkB2mjT_RTdqenX5Ag--.46181S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyUXF17Jr1xXF43JryxZrb_yoW5Zw45pa
	yUKws0krWDt3WjkF1UXr43uFyF9w17GrWjkr1kt3WUZa13CF1xZryIqFyY9FWkZr97Zw4a
	qw1jqF9xuF1qvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7Cj
	xVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
	9x07bY9N-UUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgULEWo2rnInqwAAsR

Hi Jean,

Just a gentle ping on this patch following up on Andi's message.
Please let me know if you have any questions or if further changes are 
needed.

Best regards,

Mingyu

在 2026/6/9 4:01, Andi Shyti 写道:
> Hi Jean,
>
> could you please take a look here?
>
> Thanks,
> Andi
>
> On Tue, May 12, 2026 at 05:35:34PM +0800, w15303746062@163.com wrote:
>> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
>>
>> A severe livelock and subsequent Hung Task panic were observed in the
>> i2c-i801 driver during concurrent Fuzzing. The crash is caused by an
>> unconditional hardware register cleanup in the error handling path of
>> i801_access().
>>
>> When i801_check_pre() fails (e.g., returning -EBUSY because the SMBus
>> controller is actively used by BIOS/ACPI), the kernel does not actually
>> acquire the hardware ownership. However, the code jumps to the 'out'
>> label and executes:
>>
>>      iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
>>
>> This forcefully clears the INUSE_STS lock and resets the hardware status
>> flags without owning the controller. Doing so interrupts ongoing BIOS/ACPI
>> transactions and totally corrupts the SMBus hardware state machine.
>>
>> Consequently, all subsequent i801_access() calls fail at the pre-check
>> stage, triggering an endless stream of "SMBus is busy, can't use it!"
>> error logs. Over a slow serial console, this printk flood monopolizes
>> the CPU (Console Livelock), starving other processes trying to acquire
>> the mmap_lock down_read semaphore, ultimately triggering the hung task
>> watchdog.
>>
>> Fix this by moving the 'out' label below the hardware register cleanup.
>> If i801_check_pre() fails, we safely bypass the iowrite8() and only
>> release the software locks (pm_runtime and mutex), strictly adhering to
>> the rule of not releasing resources that were never acquired.
>>
>> Fixes: 1f760b87e54c ("i2c: i801: Call i801_check_pre() from i801_access()")
>> Cc: stable@vger.kernel.org # v6.3+
>>
>> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
>> ---
>> Changes in v2:
>>   - Reused and moved the existing 'out' label instead of adding a new one,
>>     fixing a build warning regarding an unused label.
>>   - Dropped the inaccurate mention of "another thread" in the commit message,
>>     as i801_access() is serialized by a mutex.
>>   - Added Fixes and Cc stable tags as suggested.
>>
>>   drivers/i2c/busses/i2c-i801.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
>> index 32a3cef02c7b..b29c99ed3883 100644
>> --- a/drivers/i2c/busses/i2c-i801.c
>> +++ b/drivers/i2c/busses/i2c-i801.c
>> @@ -931,13 +931,13 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
>>   	 */
>>   	if (hwpec)
>>   		iowrite8(ioread8(SMBAUXCTL(priv)) & ~SMBAUXCTL_CRC, SMBAUXCTL(priv));
>> -out:
>>   	/*
>>   	 * Unlock the SMBus device for use by BIOS/ACPI,
>>   	 * and clear status flags if not done already.
>>   	 */
>>   	iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
>>   
>> +out:
>>   	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
>>   	mutex_unlock(&priv->acpi_lock);
>>   	return ret;
>> -- 
>> 2.34.1
>>

