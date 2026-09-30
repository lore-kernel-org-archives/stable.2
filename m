Received: from zxbjcas.zhaoxin.com (zxbjcas.zhaoxin.com [124.127.214.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3E38DC66;
	Wed, 30 Sep 2026 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.127.214.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753744; cv=none; b=eymoTHa/ZwWg5vHKzZRNSqnQA7wgTYmRT/jPqYnDRd3NRp0j4HA0ueRtrmLgXE9rxWjVtpileOidWRqOjqxbIznUkoLZiyD6+da8y4NY615KsRgQs4leJcKRysi+ekjRu0nBQcXxkkmbFkv9dLsJIi19UX/jUjTVzy8Rl0mLFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753744; c=relaxed/simple;
	bh=ZQQTnOKjRcmPnugUYEaXBYs7GYtutxvtXmQFddBxHLY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qzTZTQTU6Dmm1cyK/iISpyxkm0q7diQYU2cHhlDpK78Po7gHwnq6dEGPWakadOU9e3U2AwByT3x3O1fuUIH4DsostILG8VglfXHFUOHexBmLPr8SMJ1NYKJPVWQp1JHMN0MHs9spGs6kvKkILcxz2Sw09YKJRsdj71InvjlT0Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=124.127.214.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com ([10.28.140.201])
	by zxbjcas.zhaoxin.com with ESMTP id 68U7Y0sK022291;
	Wed, 30 Sep 2026 15:34:00 +0800 (GMT-8)
	(envelope-from weitaowang-oc@zhaoxin.com)
Received: from [10.29.8.50] ([10.29.8.50] [10.29.8.50])
	by zhaoxin.com (8.30) with ESMTPf33c0b30f82ad74634b62c1d0c3550f6
	Wed, 30 Sep 2026 15:33:59 +0800
X-Eyou-Smtpauth: weitaowang-oc@zhaoxin.com
X-Eyou-EnvelopeSender: weitaowang-oc@zhaoxin.com
X-Eyou-From: zhaoxinweitaowangoc <weitaowang-oc@zhaoxin.com>
From: "=?UTF-8?B?V2VpdGFvV2FuZy1vYw==?=" <weitaowang-oc@zhaoxin.com>
Message-ID: <345d4bc2-1c50-4f10-ba5c-ca49e4843507@zhaoxin.com>
Date: Wed, 30 Sep 2026 15:33:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/apic/msi: Fix MSI interrupt affinity configuration
To: Koichiro Den <den@valinux.co.jp>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, WeitaoWang@zhaoxin.com, wwt8723@163.com,
        CobeChen@zhaoxin.com, stable@vger.kernel.org
References: <20260928164839.6381-1-WeitaoWang-oc@zhaoxin.com>
 <6mg2eqdehsmb5fh6hf7icsha2547xfdfvulnycawiit2czhhmh@6bbmicaoz2zd>
Content-Language: en-US
In-Reply-To: <6mg2eqdehsmb5fh6hf7icsha2547xfdfvulnycawiit2czhhmh@6bbmicaoz2zd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Eyou-Sender: <weitaowang-oc@zhaoxin.com>
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:zxbjcas.zhaoxin.com 68U7Y0sK022291

On 9/30/26 00:29, Koichiro Den wrote:
> On Tue, Sep 29, 2026 at 12:48:39AM +0800, WeitaoWang-oc wrote:
>> commit b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI
>> quirk") try to fix the issue of misconfigured non-maskable MSI quirk.
>> For non-maskable MSI interrupts, use the slow path to fix the MSI affinity
>> race. Maskable MSI interrupts use the direct path to update configuration
>> info. However, the current code logic is the opposite as only maskable
>> MSI interrupts will enable reservation mode.
> 
> Hi Weitao, thanks for catching this.
> 
>>
>> Fixes: ef8dd01538ea ("genirq/msi: Make interrupt allocation less convoluted")
> 
> I'd rather (or also) add:
> 
>    Fixes: b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI quirk")
> 
> As I recall, I started out trying to fix the issue, but then got too focused on
> removing the flag. I missed that the check needed to be inverted. This
> left the race unfixed and also made maskable interrupts possibly take the slow
> path unnecessarily. Sorry for the trouble. Feel free to use this if it helps:
> 
>    Reviewed-by: Koichiro Den <den@valinux.co.jp>
> 
> Best regards,
> Koichiro

Hi Koichiro,

Thank you four suggestion and review. I'll send a v2 patch.

Best Regards,
Weitao
