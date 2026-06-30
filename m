Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6716EE56A;
	Tue, 30 Jun 2026 01:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782782670; cv=none; b=jWhfREl9j/iH2WE4lUZ/hp7wtLL3eGA7zhOdiVhM7W8Zoaq9wO27Tuo+pENOeiJdXr2Kdyp8p0jrysdUml28GTNqsjVo3s4jeOsqKhZ8Lt47h7Ju/a1U6R7GBrvdVw6wD2NtN9COnkjGhJZFW0TzNluDlnZvden6SH3JKNnAdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782782670; c=relaxed/simple;
	bh=9Dt3ugMbyvxbHPurxurm0axHXB3YPx1+e6HlvVdQOpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mb0Wlr4FkSXWQZQ3WKxeSHlK3eta6Xd7sRZfYch6FzXYzaDkcyEAz9JlrIqE3SvZN2Lf2XJD4wIuqMe1raxcAdiwUdHpFRcQr77y/fIg6wlEdao3DtsJ55JzNn78104Wzvs6VId0jP+a6dkua6xmKH31qRFDSVvg7QPiBHJTNIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=YM9pWR9F reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="YM9pWR9F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
	MIME-Version:User-Agent:Subject:To:Cc:References:From:
	In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=0CbvUhC3E
	PNJxYiDQGqrWEQJYeX+UOm9+WLe7dn3Edk=; b=YM9pWR9FVC9K5rmbuBrXStSej
	iSJ53gUcEpjgtuJsX6JWbnUpb5O/gCiSEEB4HL/BhVUL8WAXlcuKsfEMYN9lGt6f
	gZeWJ68BO8am4seoZg8BLV1hGMdhYJ2uuv8GMqEvTUBO7ijJGiTmQwyMej/FJPuh
	rMXCwWHCArrG+fg8BE=
Received: from [10.196.180.86] (unknown [113.200.174.80])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkCWvROmGkNq6nNGAA--.45524S3;
	Tue, 30 Jun 2026 09:23:51 +0800 (CST)
Message-ID: <5fbd827c-4c4d-4364-882c-41d2fe666fde@stu.xidian.edu.cn>
Date: Tue, 30 Jun 2026 09:23:50 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10/5.15/6.1/6.6/6.12] agp/amd64: Fix broken error
 propagation in agp_amd64_probe()
To: Andi Kleen <ak@linux.intel.com>,
 Alexander Martyniuk <alexevgmart@gmail.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@redhat.com>, Sasha Levin <sashal@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>
References: <20260629102124.252403-1-alexevgmart@gmail.com>
 <akKR2bNYFokN43Sk@tassilo>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <akKR2bNYFokN43Sk@tassilo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:BrQMCkCWvROmGkNq6nNGAA--.45524S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWxGr17WF1DWF18uF4fAFb_yoW8JFy7pF
	ZIqr4DtFWvgF10kr1UAw4xWFyruw1vkay5GFn8Ar109rn8JFyxCrs7K3yUW3s5Ar18Xr1I
	kFy09rZ5WF4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU90b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7Cj
	xVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
	VFxhVjvjDU0xZFpf9x07jnAwxUUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUAEWpCi-RLJwAAst


> What is special about this virtual environment? Nobody else
> seems to have seen that in 20+ years.
>
> Or maybe the Fixes tag is not quite correct and something else more
> recent has caused it.

Hi Andi,


You are right that normal users will not see this crash in the wild.

The environment is a QEMU-based driver fuzzing framework. Rather than 
functionally emulating specific hardware, the framework extracts device 
matching information from the driver and synthesizes a mock PCI device 
just to trigger the driver's binding and initialization paths.

In this case, the synthesized PCI device matched the AGP bridge's IDs, 
forcing `agp_amd64_probe()` to run. However, because this is a synthetic 
fuzzing environment, there was no physical or emulated AMD Northbridge 
present in the system.

In a real-world system, the AGP bridge and the Northbridge exist 
together. Because the fuzzing framework provided the mock PCI device but 
did not provide the Northbridge, `cache_nbs()` returned -ENODEV, 
exposing the flawed `== -1` error handling path.

The `Fixes` tag is correct. The logic flaw was introduced in that 
commit, but it remained dormant because standard hardware configurations 
do not produce this specific missing-hardware scenario.

Best regards,
Mingyu Wang

