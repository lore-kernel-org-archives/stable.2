Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048818;
	b=V715rHTKTUyxNOaKm7P4q0th6XmzFHX0BCj1BM4btHXwxcvHrKjdCRK/tbKaHhOrMSLl
	 UaGkb03A0KcKvIhLYLV9o8aS73Bi1PORPaDByiyWzGKmf/yJqhZIuHJG43XmJVwp4+g91
	 wFr4vbbfNDR0SiPr4fOL+uR5jcGRs25QW79FuN4s3ddbq/jji3rKD80jMh6bM9VBlEhEq
	 IYL5bF08b4KyySc10Ip9qlzZMBhM4d8qwEW+S3FoR9xzC+ExUBlD2nLtnOdy3TE50TM1L
	 k6on5LnjLNiHGzpt1NOLwU/7vR2ljjB78y3ICbOZLVFCkzMLXUOvl/To8+FOPZrr3iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=k93Uquzi2gmvL8btLkqz1m+7uDv12qNerGrKi9jXuw8=;
	b=jSPpuf83+pIWDiVhsPn/UIIxT0rHAKUWCIrY8YBqmWTgyKsIesTb1NX+mIisJie246sh
	 vkto/WUnVU4/6yRX5I7Kc61/zEdeyM4J6Vd2sHaT+/9yjUW4GB272wbdY3hkVK1Rn7UT3
	 1GcL9gNU0VkPVQuKrMf0RbGRkLvkDTrAs8/QRkHgwn1KcLj04Xns6ZK53eZYrKgXKK/V2
	 W0qFEviGAe2tmOhxqDNfV7zb6SkU8v+pSWJvDxBS9+KiKJwEHLGb9Z34O749Ovw6Ur/+9
	 laNGVfnio8mDeyFS7C7aQtdjdDG9ndjkdLixNgHQHd1saCtIthmg8CgVW8DZaDQE5gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yBQznKcF;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A07606D804
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13A07606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yBQznKcF
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so15719495e9.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 02:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794048816; x=1794653616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k93Uquzi2gmvL8btLkqz1m+7uDv12qNerGrKi9jXuw8=;
        b=yBQznKcFH1qW2p5hPPNyh8Ph+Y1MExnF4KNZYxHzWNa9DWZlgo7aWr9EktqX59K3Zk
         m8eagAnh96qTyut5zTrfKX9PtxagT3C/xz4nGUdTBt1SsV+RtL3WiQNQ3OVAwtSzB7p8
         ZoVA0zkmzDzNzqMNJTGZIwO/fNW7cwo/jfNXagnToyZt3dyBH5fQ3fMqekGPJZaM1ZSV
         DwbB8HQozKv5+HeSwbRsoAVi6lwh6MS7n1psEHAn/tqCmGM+TKE1k1J6l9/uZHFCCZ28
         wICCkzqAh1rGQogdAjy3kqcyoVOVJkt6rtxruUrvFwoFMcyx6AJzXhYl0SgohnNCjnzh
         kHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794048816; x=1794653616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k93Uquzi2gmvL8btLkqz1m+7uDv12qNerGrKi9jXuw8=;
        b=VzwZ+pjKO4pXj7CGwwdoc6AXhfmKUEScY3P+0kZWlEXGS2mLgBTNxaisVpgKGE/wV5
         33ASZxHSoKOgpGsPYj83TOm74byMtk9GtdDwoaXCoE2GKYainhShvRPaE5OOYYNWgEnA
         hSfBKelHD44A5Dkbnt5cHuo6q/Vv5suiDQVLCVSBzjIHo2ev5Gja0n8/AC8xy4bsypr3
         MCLk2rbMVND8LcoZMKXpy5GDvZF6SuYwAPgDqCU45TNh8ytH2ZyfVr2fnDxyAI0dGhVE
         0xdZ4XeDqvM6TOnrkdufW5tnfrV8GDVNJ8Wq1JfAYkCWTbPFQ7ZlehwkSYNIVOR3fVq+
         GYWA==
X-Forwarded-Encrypted: i=1; AKwUvBxzaovpS8J0Sf/m5U9sIkBAinZTKeDYSBJHgj5C6idtwX+8MM/WowyY7eDONOFiRQ1+43X1O6U=@vger.kernel.org
X-Gm-Message-State: APuU4Z99BaHgnN9yU8WNq+1heVvCJQQE3IfMn6Wc0Vwuxufum1l3EBpD
	7/mQgABZlFNmEhJkNqY95ioEdAHzo7kdYLBRnsmv6tc+QiyJOZDid/8+uYxh25Hy
X-Gm-Gg: AYBFou3P9d6MB3tS0bhu8aMZsK7rzgSJ3C3Nrm06BdpF3X4HjGjl/qMzd3R74IfgKbR
	0IHc3pFgaMvAJiEMwawIpkda8hidzF+0xdOddjHivb/fdMuFmd7LqMdnyo9cJFktodVYd62AUIC
	s9s0kcUzt41+hOexl+6d6TS+eWrnJbISap74nEU6Qv2gWJG6F6XUFF9fxjq7cFy9qzOlJsZBXV3
	QVG4+a0xBK1Iba1i29usInXo9O7sft8UB8/1wH4COVvDm60RroLfVMDc9L1O0bjxCcDS/yjKECo
	4aZAkZT6/V+l2SYacm8rQ6kqA3wgSo3pojqsm8Yx1c5+uc+QQ/0PuTh2I8DtVTGL9b5Npzi5Hb8
	ptNkdeaM+86y0Cu8sVPmNzU8N5EnVO1EvuVGDWOQOKStaiHbNqyVxH6CSuNYmwSvcLdMJLWY/cz
	7YR7W4kSGubS3CsWl+6karD0Gl70IZf3pUmnVGK9ZDJcTCCDLzWgMLCTXt8OAy1jJLNIvckyYUh
	iOMO0qxVRGk4V3Q3HutW/zNnKRDpy7zGZXoNOMlKIgqh2MlPywgAnq3gWENLb3qGbYBQ3aIom37
	8oK/rmcpzFJGghv4lok9EW+Hpa32dZOlf62i70lbtaj7j++qST1A5FIi4QCitEqJGfHbF999gmQ
	sQOHaQQn+Ro/HicDYlF8Q6xfE2xw1ytrA5ZsufvhTMb/O6LoP7d18ijmgTSLfgXAcnDge4J0jmC
	xzzK2vQULlpA==
X-Received: by 2002:a05:600c:1914:b0:4a4:7a8d:c436 with SMTP id 5b1f17b1804b1-4b6de788f5bmr87694475e9.11.1794048816330;
        Sat, 07 Nov 2026 02:53:36 -0800 (PST)
Received: from PC-Marco.lan ([151.59.49.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b8af10dd35sm42291335e9.4.2026.11.07.02.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:53:35 -0800 (PST)
From: Marco Ziliani <rylos78@gmail.com>
To: Kyrylo Biryuk <illofspeed@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ata: libata-pmp: disable the SEMB port on Marvell 88SM9705
Date: Sat,  7 Nov 2026 11:53:33 +0100
Message-ID: <20261107105333.19934-1-rylos78@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107081335.3360920-1-illofspeed@gmail.com>
References: <20261107081335.3360920-1-illofspeed@gmail.com>
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

Hi Kyrylo,

On Sat, Nov 07, 2026 at 09:13:35AM +0100, Kyrylo Biryuk wrote:
>                                     softreset  reset failed,  last disk
>                                     failed     giving up      attached
>   7.4-rc1, no libata.force          60         12             197 s
>   7.4-rc1, libata.force=N.05:norst   0          0              70 s
>   7.4-rc1 + this patch, no force     0          0              11 s

Thanks a lot for testing, and on a second unit with a different setup.

The norst row shows that the commit message is too strong where it
says libata.force cannot work around the problem: norst on port 5
removes the retry loop, but the last disk still comes up about a
minute later than with the patch. Niklas, Damien, I can send a v2
that says so, or you can reword that sentence when applying, as you
prefer.

Marco
