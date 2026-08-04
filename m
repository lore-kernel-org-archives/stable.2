Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C44143BDBE;
	Tue,  4 Aug 2026 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834980; cv=none; b=YXGc6le8LKXR87HgJmmIWLTvUvSXzmGAlzgHvoTfbaWaBODBDu9ISkhtW5rYIbz6+fGIejeN2shCCMHpjWMAGMB5bEebndntTEa6o0H9Qx5Y6O5oNBFWlli2lZSdU8Kj4JDg32+v2KAkV8QjwQjZmF87uhwGCkXmtvM8VxZJAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834980; c=relaxed/simple;
	bh=phSDRUFl3KB9oxmhLnro70tI6ZGimYikKTJ+ouQ+SwI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CKm8H0hZgVhQ0MeoSXyJPJpezzAh0Vq9/ralwdSeD+3YNU56cG62WGJlA3gq4HkOJSIQtNHoSycY8WsJSLBxCSHdrEOqKzvVAtZwZ5TkTvcx33OMQcjKH50Uft7BN5h181Adp8C8LJtjuYKzsO1AR4LQpeL11mg/BbMaxfmCcTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.190.132.129])
	by mtasvr (Coremail) with SMTP id _____wDHoX7SrXFqzRNkAA--.13767S3;
	Tue, 04 Aug 2026 17:16:03 +0800 (CST)
Received: from smtpclient.apple (unknown [10.190.132.129])
	by mail-app3 (Coremail) with SMTP id zS_KCgD3DXDRrXFqHMjvAw--.8415S2;
	Tue, 04 Aug 2026 17:16:02 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v2] tty: serial: max3100: shut down timer before freeing
 port
From: Fan Wu <12321260@zju.edu.cn>
In-Reply-To: <2026080353-bats-jailhouse-804f@gregkh>
Date: Tue, 4 Aug 2026 17:15:50 +0800
Cc: Fan Wu <fanwu01@zju.edu.cn>,
 jirislaby@kernel.org,
 broonie@kernel.org,
 zhao.xicheng@vivo.com,
 linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0FEECD29-C7BE-4D4D-8441-3F8BA3C55902@zju.edu.cn>
References: <2026073036-coping-starter-ad07@gregkh>
 <20260801061208.356142-1-fanwu01@zju.edu.cn>
 <2026080353-bats-jailhouse-804f@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-CM-TRANSID:zS_KCgD3DXDRrXFqHMjvAw--.8415S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?anxzZwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WM+1x03kkzY63nJhmkcBmP+T9fi2CBDPmnsJbLEd5LTvupJ
	AXZl4WhrGaD1d4lVFbI=
X-Coremail-Antispam: 1Uk129KBj9xXoWruw4DGw4kXryrZF1UKF4DAwc_yoW3GFX_Cw
	1kJFnrC3s0vF1kGry8GrsFqw45JFW0qryrAw4kJa1kG345Xr4DXr4jq3ySvws0qa95tFnx
	uw1I9348Z3W29osvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb-kYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjcxG0xvY0x0EwIxGrVCF72vEw4AK0wCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
	cSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

Hi Greg,

Sorry, I don't have MAX3100 hardware, so I have not tested this on
hardware.

You're right about the extra state. I'll rework the cleanup to use the
existing startup/unwind state instead of adding irq_registered, then
send v3 after rebuilding it.

Thanks,
Fan

> On Aug 3, 2026, at 20:56, Greg KH <gregkh@linuxfoundation.org> wrote:

> LLMs _love_ to use boolean flags to attempt to figure things out that
> they can't seem to determine.  Are you _SURE_ this really is needed?
> How about unwinding things better so it's not required?  You are just
> adding another "state" to the device, adding to the complexity overall,
> which is generally not a good idea.
> 
> And do you have this hardware to test this with?
> 
> thanks,
> 
> greg k-h

