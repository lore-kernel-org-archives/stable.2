Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056375;
	b=ONy6v1taVYUoy1Zeo7QFcOh1AvdUmfz8qj9MDOLjb6v4/C8X+RSWk1nPqdO63RdrdYSX
	 sf/fXRwvzoZcNmA4k4/rUcOh6VuBFa/EnsimszbS5LAWi0jHMukZRV4cf4L5xJ7+rgt8G
	 g3s2YQqkNI+kFGCR+Vvl6BiXyZap8+8ZA+V8xyvq7vIglAfo8IuvQ9zzG7gPyUSPg0dSD
	 8PeftboNBOuybljABbrzYeJDYO4oD4Iu76MqNZN9CVfhcQ50ceZcDHsGSqenMwjDw8L6H
	 eY97DupJ3n1io2IuKmCG9bUFYk/ZMSjh7KWNB/TwF2dS6w3Z+BqaD1VmZnjpsfiMkPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TLn7TVaVukXMVmZsUzU1TI29I6h9VPQT25Hl23f6vc8=;
	b=vatYU7/vqrlgBDwKOc092XPVkXHULqamGqyPc1K+OnXgR8T8Clge94ko02R560RZNT+k
	 HwkJJO2Hf1bOhmYVWtmFKUEya58VYDY/P3fhnkEca8CTZxMEGDRTUXk/028S9auv9cl4J
	 n6Vxxi/ccxCtNPsJLg+19bTNwnfpMTI5NHgSFEllOTGIQIwbeU8WqWBoqf90ZUjCAlmiV
	 Z89VRwFfGNURBBbSuuriWbgfV511/VhMZMbeY71PeKds3fzGmdMP5FEIsKqoE0WgBbQmD
	 9+1ghdWvayWaGbCcA1jRLJxVdmycLg3fbxaEWUCujUHBLJWSGMTf7bs3lbUz5fBY4OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aRilCere;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93E6606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 23:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B93E6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aRilCere
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso35998275e9.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793056373; x=1793661173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TLn7TVaVukXMVmZsUzU1TI29I6h9VPQT25Hl23f6vc8=;
        b=aRilCerebHy+kF6vnnvW0jj/Q9uLDDrTywoyUyeMhiipONTZd2IUQluvjI0jnnKGNP
         5nppDehQuYJicLjntoH9W0d1gEvh5uvm+Y++H7Z/gm1g5FHCsSMqG6mFrDIOgDePHd38
         PqsapbD53k7pazaNKpc+I6MVV5O9Oj0+G3G21QQwXCkcFYjC1xE7ZAyOBZYcOGAa3MpX
         MMMkrR1ojHvLZD0LPu5JK6UmNI79ge7OFq8S2VE2LwsH/NQB8NHBRtG5hy6YpbY5aX4E
         k6JkCxilvej2FO2/anbmOpgOVrJx3N7Z0JiRMhgzbJq1cwNYOhT57VqQhUZ7vBjFgkvM
         E1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793056373; x=1793661173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TLn7TVaVukXMVmZsUzU1TI29I6h9VPQT25Hl23f6vc8=;
        b=Sf+invoM+veN0CiI1tnRvBd/jhgMGsSad9rUSW2TXM7isVVNFiA4ztKM7MQhpybb4Z
         +8FwZk8XeMYdfFqvMBgODZrhGB919OEPMjVjW4e6mxLBTsEquq0LWpfVu71htUTXwxQY
         s/3nqEJyl/ZKms1/DTcDGI5zonx0/JRjizYoJ+bFxkjAjZY6hSIgiWvxCSRTsrquW3kv
         ZHZBarY87+HUV4rxqZNkals3kUJL3nCQTw4pOZ0cSP5jJp/Yn/U97TCjKNQxVfInuvND
         2zLkc+KmSwbW37lwoPrnUX/lfosmvHZiTUu+IcmmtTiSV8f8QCEk+kieZ8hqyZg8B25T
         5bsg==
X-Forwarded-Encrypted: i=1; AKwUvBw2S+lG0MFhuQ/L/I1Ac5UVocJ058cZ2ttXObgcakG2Kybb6J5jRzchX/DIsaqJ58IuQtuHmlQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfOK63AXcaNzMeqHGBQ1YzmAXR1HNSis2cQl6qr3IpEdcDHxr/
	0KtQiTJ2z9w7CHDEPWu1+LtrfPPJVUYaIX0s3bJh0mWZds16H56daZrk
X-Gm-Gg: AYBFou0kBvWUwK0P4VGOr3lRBHginppZRbp7jfy/XdcZSy8RsAzm0PLtQwa+ulz/Trw
	CP/z/CoeAN2vcpHN4d0jGetefzI9e/MiK6ngx4OM/jjd9gPIPdo7Zz6jQfkbvRRaAixKO6K7I+y
	dgp6Ptf6oV7Qto13zjo4xxCVeEaQftHP8+HPSBKMVaav6UXdRd0mYTfRK18FaSgQFSETtzdtKDS
	eb0etymbSuAkcyAYmAFVHDAIh9gw/BeDBcFz69lyO7+r/LAnAXhmZBwnF7lONYBZT+xLYlxldi1
	Br5pqFlhSSCgeRs8GpJfy+XzDWRlbuRthbZyPkBdyJJBwHb2vuJ3lWPRaiSPAmwgNUxl/aepC04
	C6gY+P35HzJYqSnA9UzMO0FLX8SQnQzPp2jTdyeTWBJM0+PSQla0ojURm3HMtE7V//cJsuoK/Mn
	gP7UZmU5cOIHgwZhPVjcVwaa3OSul0geMsJ7VIk3AguYCTq5+kuRRrkcapAwB2VP6vjEy5D5qp6
	EMumCFF42RPe8XCe2w4J+DPT0sTeOFS42Uio4rlq38baB/PvpOWLXWAevgwUWKzK47x2QqvD7sC
	CISShOUkLzcdmxe0Z5D8Q96d7Zl4AqdG/tbDASvsS4SS5sR0NyVSdIUbgsRrdw==
X-Received: by 2002:a05:600c:840e:b0:4a2:b89:b02 with SMTP id 5b1f17b1804b1-4a35acafc84mr143906785e9.10.1793056373131;
        Mon, 26 Oct 2026 16:12:53 -0700 (PDT)
Received: from iamyoubutArch.adf.bham.ac.uk (smal-20-b2-v4wan-173097-cust1152.vm20.cable.virginm.net. [77.97.36.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a574088sm212047515e9.9.2026.10.26.16.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:12:52 -0700 (PDT)
From: Filippo Falezza <effeffe99@gmail.com>
To: Joonhoe Kim <26rote@gmail.com>
Cc: Filippo Falezza <effeffe99@gmail.com>,
	mani@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	christopher.lew@oss.qualcomm.com,
	deepak.singh@oss.qualcomm.com,
	pranav.phansalkar@oss.qualcomm.com,
	andersson@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: qrtr: announce local services again once our HELLO is sent
Date: Mon, 26 Oct 2026 23:12:36 +0000
Message-ID: <20261026231243.68801-1-effeffe99@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022163116.1042-1-26rote@gmail.com>
References: <20261022163116.1042-1-26rote@gmail.com>
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

Hello Joonhoe,

I ran into the same problem on a Motorola Moto G 5G Plus (SM7250),
which I'm bringing up on linux-next (next-20261021). Since the HELLO
gate went in, the name service's first announcement to the modem fails
with -EAGAIN on every boot, and so far I had been carrying a local
retry loop in ns.c to get rmtfs announced to it.

I dropped that loop, applied your v2 instead, and booted the phone
seven times in a row. The modem came up and registered on the network
on every boot, with rmtfs serving it, and the phone never reset.
"failed to announce new service" still shows up once for a remote
whose HELLO arrives before ours (one boot logged it for both the ADSP
and the modem, others once or not at all), and the modem carries on
normally afterwards, which matches the replay doing its job.

One thing I couldn't cover is a modem restart: on this phone it
resets the whole SoC with or without your patch, so that's a separate
problem here and says nothing about the patch.

I did the testing with the help of an AI coding assistant (Claude Code);
the results above are from the phone.

Tested-by: Filippo Falezza <effeffe99@gmail.com> # Motorola Moto G 5G Plus nairo (SM7250)

Thanks,
Filippo
