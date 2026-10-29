Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288228;
	b=VV89z7piw5yeklWepjxlARvJ5KDsVNF8RzYckKj+cLfBVlL7V0L6qr+XAPS3buKUYLkH
	 /JQUTb6UlH6l1bAwxDKwRETLc2Vrq27tyikLCoCBuzT9upTJCYk/InwJ628UkSNviWRu/
	 rejKeCE8TigPVoJi2vA5PoYQfBbMt4TBvmVokTc4U4/F/A04Sddb8+ea0YY3ZsWo9psez
	 JADJcqdPA8IpSgl7pkIUwdQLVMJQUjMyZ8c9Ac8Gg9mTZCfosrAV/xB7cVO6aQLiCPZes
	 Osp+1eoh5Iw6FZN/Of8S24QQO+t2Iz3avj6In6BGV11fyN2A24DegkIh2/34ttUPz/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ISkMz3ASxfr+lKCh/nGM5qIpjGO+THkfUP4Oe9g4JJg=;
	b=WjI+Ue9T98CGz51gJwP2PMg4Xv/CMbpHv7AhyqLTnBZujskUoIqRQH2g9XkcCrEb8rmJ
	 bCop03qmR/FGXRJHxo739PRGI28qcSQjR54GDddJXk2ANW7JpfGF82szTK4ulk+zDNl86
	 Q7zFcbTE7otqmWXnoXg2UoXkVNyMpPNmx9yJ+UvKghC7tuIIuMzAXdXcbkHisv9oUGeE9
	 flwYylFR2eLjnn/p7SVvohk0ptZWRPFdm5bhE/QzKkzPTNIRU698Q/btwUpoV7MkJDBdB
	 YcbIGw0j2eSZ5zQzwMSXFkTYJke120KvRCUPZVbIS0S1KRx7Fe8raL3yyO40lao5/Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fyX6a1Jm;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B0606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 950B0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fyX6a1Jm
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36661f953e4so3673195eec.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1793288225; x=1793893025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ISkMz3ASxfr+lKCh/nGM5qIpjGO+THkfUP4Oe9g4JJg=;
        b=fyX6a1JmIX16giFT5SgiksZLB+bGccozjMTwvQ5Hy6Gtb6320r0NfZkSsMUjcW3kHU
         SxyltN/matoVdvpYzfSUf30tVIhsxZuB35PNIOSBP19ZQGeBeEcGT11s1WtlEPmJL8X8
         uEn3l0QtNap2JpfYhO9bSZQMA3TxLRXNHvIslmmdFviP3OyDwsSdeUMgvwrCLYBPgBl8
         AtYw2GnQBisbLMofFI+kl9OTkGnfxkjL5WQ9tx8av5ceUUbrlDR5dfsczLEdR3E0SBfE
         ysMN9kP1Ai2DhAj95oTEw9eSGbDJdldHVLCcaqzxwPpNd3jHyjqy3wcCMELf1Noc1G0l
         vpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793288225; x=1793893025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ISkMz3ASxfr+lKCh/nGM5qIpjGO+THkfUP4Oe9g4JJg=;
        b=2GinTryTRYN7kRv0SY7UoqWqAg8lw8rDyRv8HHgiX4G90DizM5kAjQpBksOXbUnA/y
         X7iAU2qEVtW1TYBAKc+GxzK3Kl+3/nJ3zjtD8DKxVhuike9cUcrGGmg2Gq5TFPB4VGub
         qAgR6o9oP/JFmyC0KDSYI/bNwdWs9EpO8OQc1a91bUqgGIzeAWYZEI347xW3JEYA3Ixv
         Zj2OSXTgFLtkyCVpndMst5p9XJe1kPJdApe1T8cPrTyp5gGuTjsskbdAlQMPpoFBiEuB
         ROxQDOAByZJ9X6K2zBJ/+Fq/zC/GzBioDIdGhYNThIEX5Ouu+w1zpxGsqTO3HOFSWRg8
         smsg==
X-Forwarded-Encrypted: i=1; AKwUvByuwzpcdLcD1k+UQ82mwZ/l6tBTOSx1GtC4UJORhWKvPb2KLypKU1HRASq4OX8v6gNk4Zwq3ZM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIo+Gvl24B4+rZ/kQIFXhPK+HCFwjF+0KEcncP9fbBjJ7yu+1Fj
	+7vLvtDnfWrKMWpGKxilh5eZxeAum96/bHt3E1rU/H+0h0fotXpq70YmnzLM4s+mAi8r7Pc9Gac
	kfPzAoPY9dp9at++eW3PSc9xCxaBA7phSC2Es2VfkKX72QW5O5rs=
X-Gm-Gg: AYBFou1svpRicNkErsqkb8lRygAtNdRJlZw4iqWuYMy++kUvVysdrs/bELn9xMARNpo
	YhRIYT1IDm29wAdUg2K+Lk0dx9PvWlnuFaPFsMDyEEuWpk0sr3/56M7hRLpzCNYqAg4p2DFVURK
	O/GdZ4w3r4WvIFEwrLN/CZ/o0abLCJecrbBozzZ4kdAm1onJ9lknbpEPFIKylCnRHpCTXkUfRHE
	2gxwI3p2k4l2I9mgHnsSXbujEmRVPc3ZMDnzMW0wkHd39FMsirQIa/Mn7w70mEyQ9AhsldAU2Hd
	mNpiaRtph+fDQIrFaa70FhJPmdC0GMZq8Hxs25rNTgGhmPJubngTLBeRTJLQ9jGvOct9CBbsoqb
	GATM5szR64axycw4OVtppUsBFsAmju6IvBisjuQuREjWQ+O0PWl+WAON8e5vSJ6+ymKIxFJM9r8
	gf78AJSfS2HcmyolSieYam/SP+tOFjx2kZHMwjWJEMurP1Y8BRrV+Jn5DCTevc9yodmhOveo+SA
	jBOkXAVEg3mRX1EgKP40eALyg8Zf24RVk6Sr+O+DMbmeKjLAUL8OugtmFJ0SoKLl2s+uQ4Q0Y1g
	8nwnCY2n4IN2hLQyCu9CevrLvvrF9JAyCZy6Zt+wTh2fQ7HDA2s3ftFUgIgD1MkT
X-Received: by 2002:a05:701b:4586:20b0:1a1:8bac:c1c1 with SMTP id a92af1059eb24-1a6cc069414mr7188123c88.15.1793288225045;
        Thu, 29 Oct 2026 08:37:05 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75e1f2de2sm15338311c88.13.2026.10.29.08.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:37:04 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net] inet: frags: limit the truesize of a reassembly queue
Date: Thu, 29 Oct 2026 23:35:39 +0800
Message-ID: <20261029153539.1224463-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028182934.2236310-1-edumazet@kernel.org>
References: <20261028182934.2236310-1-edumazet@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Wed, 28 Oct 2026 19:29:34 +0100 Eric Dumazet wrote:
> @@ -510,6 +513,7 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
>  	if (offset)
>  		nf_reset_ct(skb);
>  
> +	q->truesize += skb->truesize;

I am not sure whether q->truesize should be cleared in
inet_frag_queue_flush(). Was this intentional or an oversight?
Although this does not affect the fix, after reinit q->truesize includes
fragments that have already been freed.

The call path:
  ip_frag_queue()
    if (ip_frag_too_far())
      ip_frag_reinit()
        inet_frag_queue_flush()
    inet_frag_queue_insert()
