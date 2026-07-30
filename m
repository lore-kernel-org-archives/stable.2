Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3CA382F01
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426789; cv=none; b=argGQ0pGbafNTvLGHhOSCl4Jj6Zt0W2MVuSHmn/zlLIEoqgUoDB5tDKCy3dSjx78omcOsbqyg+LqsqkghxEWfdcNTfE7tFHEmrVZJUucWnmrtrz0KygIZ34uBZ8YaWZ2oPqrCpGEmuDndt9/Zt3pjXAgOsdgygKq2v0AnVJe0JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426789; c=relaxed/simple;
	bh=VtdxPng0YYBiALhxGMo3ep9mcH+EbhIpTkEyJddDs4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsM2OGOEN8ZFxIqh2YVxKWp99NtSLoUY398/oe4dwVHikiBYo53GUBe4wRM13aiUVaYZGLKFw8nt+mElV/P9GEz7uZ2sD8knbx/0Q2XR9+u/GoBCZ8INTbEVEzGmkkjAMilWNav4mF2eeolSzYAzDYmQ/BhjNuBptWu9JOnTbBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqeJc758; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqeJc758"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4955c545a94so1459545e9.3
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785426785; x=1786031585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=llV+7vajoOu21zsyKEPa5kePWTMyBf+D//kaJbKHIs0=;
        b=DqeJc758S+U2hT2jjoH5rBKUwsnqrpk7UePXBpHEY7bd2e/8pi4ixfwKKNasXYjWsW
         pm95qM1nSFDECRCZWup4oNe/Kn4rb/7eT+8X/ArWfLoAgEO8VuIdhdVDwOOI8uO6XD/x
         MKAd2EHAUCNiQsJW/ma0+ea4IiTsq8Sxv5Kb5S97aBch30KtJ8GTOoBkY2FAn2bHc7Ym
         kXV6PdrOUcmZ7gFZID1vka1/1NL+1pdWRnsay0nbMgUa7ZqG7YpJSv8CYI1Hg12gh0Zx
         yndrzsYurKO3gvN1fq/nCs9Su1ygqOhYvIeJOiSllNmu/uwB+VuaOGTTuP50tGixOPdj
         xWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785426785; x=1786031585;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=llV+7vajoOu21zsyKEPa5kePWTMyBf+D//kaJbKHIs0=;
        b=WVwxRrALOcdELhSopl3JJewFWTGV60H2tDbP3QkxE335juIVr/JtWBW8v13Yk6MBJA
         zAV7RJEPUFp9vacG6bnnjjzLBObRfS3SnnrQKpkcVO1zIK0k5HyxUHLiuWSw5XSXh5os
         ediLXzOPHz/4HXhXB4oIBedQPCc51f3U5F29sKucWy49l4xp4IcH4uVoIpt/hlKzBLtf
         zt7gZJiniDLoRNUTULQvQFXtUVLfccE1SNDaw8097FfDCq0Ib2s3oynfNOCGolthIIV7
         hSrAbFx4fkKbD95GGOKFcA7/BCJWX9Z6Ns/8VBUn2h18dNvv03c32OGHVvNbSlj7w/nw
         AzOA==
X-Forwarded-Encrypted: i=1; AHgh+RqAglHrNACxbUxgmHf3HXxbw481lWqHlMr25h5p1srpTLJF5QIbsWDDgdh0tP8E3AD/H7nYuKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDuv0044MhWq7Yb/bnaRW+6cDdY0/rD0BnUWCQwOYR5rj8WJhy
	o13ozObTFXR5hMQdO2yLALyPjbzFRBCNvVT79gsSFgtT9B/VTCjhVJRu
X-Gm-Gg: AR+sD10v14t5ux/ukRl9jRowYoS3ZNfmGwewS1W3oNhx+ubsSEKitR3Ip0JEpT/olTf
	N6JdRxNbBIkcEY7V9yq9WQ2ebdizV1XJpzCNJ4juUOEjyE7H8rOz+iCpERXFsiR4RvbApPAOD33
	/KbSx7PnPf598qV7yCVCTFXvaKt60frj7bOj3+b/WmBFq67ZfqH7fsy1obTwM6CBjbFN3r5dQTo
	jPsk+rCzYw2ER+IJEPMYomkS+l2qIzKyYZdV8JUoG0g6Pz6Fn+KD4DubjYjmhvNfOQtsVlxOrhe
	ZuGtR6pOKdeeYbffSdhSz4Qn0oQoQwg/QYbsJOj/kbiMdjBgVCdC4bFBX1PjsOfbbOne3vmT6MM
	DvHy6Rm5adf3WnKrygak3xIR68XOB5JMNQ135oZSjeFH0fwwZ+Zi+Gyz5prj0nnjlWeIBIqsetL
	oQ0PpGP8Ch/8wg7TRjPGKLNNfq8p1mncja5/TU8wxQ+swkTbN3eYgY7MBTmeGBXzAM20qrOh9hJ
	XQyLPDZ/MPENIr9XSi9jP570V8GeZ+sDoZEQnwZtEaKE3Kzzp2zM+JkZ1QFaBiBCFu2Yx0YbB+3
	v1IJdpbBjX8=
X-Received: by 2002:a05:600c:3105:b0:495:4505:dad0 with SMTP id 5b1f17b1804b1-49804c442fbmr16212615e9.2.1785426785328;
        Thu, 30 Jul 2026 08:53:05 -0700 (PDT)
Received: from [192.168.2.69] (dynamic-078-051-177-165.78.51.pool.telefonica.de. [78.51.177.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011fec37sm67692795e9.9.2026.07.30.08.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 08:53:04 -0700 (PDT)
Message-ID: <67cf57e7-37d8-4995-9a8b-b4a48c750c9d@gmail.com>
Date: Thu, 30 Jul 2026 17:53:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/4] net: hsr: fix packet drops caused by GRO
 superpackets
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
 kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
 fmaurer@redhat.com, luka.gejak@linux.dev, bigeasy@linutronix.de,
 xiaoliang.yang_1@nxp.com, skhawaja@google.com, stable@vger.kernel.org
References: <20260724161253.79-2-xiexinet@gmail.com>
 <20260730144653.147367-1-horms@kernel.org>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
In-Reply-To: <20260730144653.147367-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/07/2026 16:46, Simon Horman wrote:
> [Severity: High]
> Does this one-time modification of wanted_features prevent userspace from
> subsequently re-enabling GRO?
> 
> Since NETIF_F_GRO and NETIF_F_GRO_HW are not included in the
> NETIF_F_UPPER_DISABLES macro definition in include/linux/netdev_features.h,
> would netdev_sync_upper_features() and netdev_sync_lower_features() fail
> to enforce the disabled state on lower devices during features recalculation?
> 
> Could an administrator run ethtool -K eth0 gro on (or add a new physical
> device to an intermediate upper device already enslaved to HSR) to bypass
> this restriction and cause the HSR packet drops to resurface?
The review is correct that dev_disable_gro() is setup-time enforcement, not an immutable policy. Clearing wanted_features prevents an ordinary feature recalculation from restoring GRO, but a privileged administrator can explicitly request it again with ethtool. Adding a new lower device below an already enslaved stacked device can similarly escape the recursive setup-time walk.

I did not add GRO to NETIF_F_UPPER_DISABLES because that is a generic upper/lower feature rule. It would make an upper device which does not advertise GRO disable GRO on all of its lowers, well beyond HSR/PRP. That seems too broad for this fix.

Patch 3 is the second line of defense. Even if GRO is explicitly re-enabled, no GSO super-packet is forwarded as one HSR/PRP frame. Plain Ethernet GSO packets from the master or interlink are unfolded and each segment receives its own tag and sequence number. GSO packets from an HSR/PRP LAN slave are rejected because software cannot reconstruct their individual HSR tags or PRP RCTs. Patch 2 makes the segmentation path practical by moving the expensive work outside seqnr_lock; it is not itself an additional GRO guard.

The two layers therefore have different roles: patch 1 establishes the safe default when a port is enslaved, while patch 3 guarantees fail-safe handling if a super-packet nevertheless reaches the forward path. An administrator override can still cause packet loss on LAN ingress, but it cannot make an aggregate bypass the per-frame forwarding invariant.

 
--
Xin
