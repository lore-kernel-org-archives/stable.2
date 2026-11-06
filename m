Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965586;
	b=eA+fbdyCP67PgfMMqCr1fX3Rb3/CHnwHUjwoQ7ft58NNAAC3YLCRrxJU7EgDdprKeS7u
	 1sKpRS6v+wj2PVx1f6+FBM1I2GE5x2j0cKJvOl5jQREHM6isfzBfriSOZ9CQ7YH6OLV7t
	 7LNnv9io9I+ENInJp17+qh5lp6mMSbU+FuLdfcSpM7r8UaRzudLwSr7O+2Bl6joI2Ccik
	 Sl9klGsu0m+GMosINlPLQk+8446Mq06ft7KVsqtUjqwvvNUW5YfliK2JVbY2JfUjhuMMm
	 8zjfd0QA09BpmLeHzVDJDcjd0lW8kZMUZtOu1ZR0DGM8MpN9wvmW7+IMgDwrpe8bHhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YLGfYC71OScNX4P7b0Ywj1iP8vp//hNbWZvlIRGfX1E=;
	b=dkNltJ7d9uD9/z2TM1hEy83/mhzuKTKt0PrE2j0kFdAcGIpT7b7ALyHQPREq4edE+Tqk
	 S32dfzTo+FUZY595W3srxJTkevOBQkAwzeZadReUQAMy92dE7DsN69qK20wmAJOyW6jfV
	 PxYaZiCSFO5MV44zABVHBg+4JNRy+gF8x7PFEVvsB2C8INhpFjKUqMzH7j5YtYOdluY81
	 xCqG6GDe1D3b3wls2EFvTHmey+kneOtnGHcj5zIJNW/RMPiXfQrcv1hDK+jsbs9HVmTno
	 vkgZf9tV0eSzOa5vHdKcgl+7+hlRDgfZfAUIYAnMf4VugF0fheKH65zSpgjzr0L8zNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mKG/AQ/S";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3B606A934
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 11:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8A3B606A934
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mKG/AQ/S
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35829219da8so1667842eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 03:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793965585; x=1794570385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YLGfYC71OScNX4P7b0Ywj1iP8vp//hNbWZvlIRGfX1E=;
        b=mKG/AQ/SA4Y2X8gh0hGyM4oubFdXoBqxMnh8G6XQzKaP0lPmU4nsMkWYHLmJ7XTPkl
         AX+JFGVxQ0NaRb95p9vzR3WUlvDZwSQzZgppzMG/kekQCPd+H17mg7rvpOXLLRodpzy3
         n0QkzjwOhxjvebmwM67xU7qvGWJ0YuYjgfYdDVBsthfsAxfXbN7Rx96QSCjNv5Px5aZQ
         eTIP4ej33VY0gmC2lD9Wk/E+CYxOjLrj3U7WXf96lZlHh2WQopOxMnRo+WRzZWYeBtpt
         2rc0uV+y0aKF3Gwk2G3Mb48I3UfLeG5bVn4Ijw2ASqMgm4Zvd28ccxxkWGET6rY5iMWl
         znCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793965585; x=1794570385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YLGfYC71OScNX4P7b0Ywj1iP8vp//hNbWZvlIRGfX1E=;
        b=cXGtF8r7gc2trvJEH+Hmv8HhMVRBHSAZLEBecRNuxvK5ug0545Ob69ddcV3byDzcjK
         JzE1BRmvCOIt2sEds3q4bA+ViZgLDSXFZL7mj7TYHoaYr7dom6h556JH1rjU7H3VbNSX
         /GPlvX8d0l0aBDfBd8jElv1/Hzf/YWYy+ldEitix8okAugQf7K1iyyxnJ3evlgOMYlVj
         VjE6x85ygJSYmY93noMpcQCRVY0DkRRUW2r9kpT9HCNIUbhR8UpNmAkF1cELLnD97yx7
         FWGRKLCCLZ2GU2mAacdt9JAsvHMhAlnxjQb/axS15Sywxvog/TKvexBguJduPDw8I8hs
         jeRA==
X-Forwarded-Encrypted: i=1; AL+hErH8De0k3oUeTcEUAUqy5cq9lwHaw3zqx7l4mSUc9gLtn/0ykMTY39MIg4jyHiST2Ei2MiDCjck=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XDcP6gE/fnP08I+cokgHRkG8ah0A2qk4VQpVE87XNc2Y1T9oT
	L1kMpsP0OcFZfLv3fc1b2ToH+kVrlJ5DnTcoYX46JdHIMraFT5gSe5jw
X-Gm-Gg: AYBFou1m5/f4Zg1XbBVhSaMI3gYzwv59XRtgkhfCu3ODY/PusoSFvToD2CONtpqb6qf
	FQYzSeGs481AUEeFZ4Va4aXDuL9VHzYDtt4mod7nUvHaESSMerzaho96atFjloLw+G6D02XPrZs
	vF67rdLrFxvFCV4eCZSc4Iv66g3eL6j+BuVVHa77zzdbPpebQfWOFu+fDPDzNI7/a1brDi0MiCZ
	EdiQ9M1LJQct9xEinEwKrUNm6GbxpH8CyuOTjhbnsEt0yMn7pajCB3KoowKBpM2VLeHr6W6Jx4B
	marfxzDdChGNlUqk46AFhAWKX1vhdcUstM16Wn9a49cczBTPnrCkwr+1Vm2jXijFMoysVZ1eR45
	JJ76tpJjHrEhnZD62JBuFZsmEj7FQSNWCZTT7RLFAE5t9b/IoegrFlQfd1hTOO6TFh/ZAUUC8mo
	GAupurjVg1AWW2TshH0p4euV54BG3XyCxqV10KZ90lbfjoXI0xE1zeJZtY8Fh9sdzxhqrJxcb+n
	rKhpXcT9Hq0g0v7J1KBwJohcWUnVQTqOcplWzgHL0OAyvPyfypGW7uvTIBT5hNnXDMI5I+XO952
	AVa8DMlCGt6iz9TsWRYyvy7z4FGOHxVlJxjQFGj0TXfh
X-Received: by 2002:a05:7301:190c:b0:361:a195:c46e with SMTP id 5a478bee46e88-36de39af458mr6879740eec.1.1793965584700;
        Fri, 06 Nov 2026 03:46:24 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:1d31:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9be7077sm6167055eec.17.2026.11.06.03.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:46:24 -0800 (PST)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcf@google.com,
	jordanrhee@google.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	pkaligineedi@google.com,
	maolson@google.com,
	csully@google.com,
	willemb@google.com,
	yangchun@google.com,
	npl@google.com,
	awogbemila@google.com,
	shailend@google.com,
	nktgrg@google.com,
	maxyuan@google.com,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Amaan Cheval <amaan.cheval@gmail.com>
Subject: [PATCH net v4 0/2] gve: fix RX page refcount overflow with the pagecnt bias
Date: Fri,  6 Nov 2026 17:15:49 +0530
Message-ID: <20261106114551.212675-1-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
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

gve's GQI and DQO-QPL RX paths bias every RX page's refcount to INT_MAX,
so a single get_page() from the stack, e.g. splice() of received data,
overflows it: splice/tee fail with EIO/EFAULT and GQI can reset the
NIC. Patch 2 lowers the bias to USHRT_MAX, as other drivers do.

With the smaller bias the driver gives up its last reference on a page
once every USHRT_MAX handoffs instead of once every INT_MAX, which is
only safe while every consumer holds its reference until the buffer is
recycled. That is not the case for an XDP_REDIRECT from DQO-QPL to an
AF_XDP socket in copy mode, a path the driver never meant to support:
commit d8a8ca14c937 dropped the queue_format check that used to refuse
it. Patch 1 restores that check for DQO-QPL, so patch 2 depends on it.
Trees before 6.17 still have the old check, so there patch 2 stands
alone.

Harshitha mentioned on v2 that Google would send a patch blocking XDP
on DQO-QPL; if one is already in flight I'm happy to drop patch 1 in
its favour.

v4:
 - Add patch 1/2 blocking XDP on DQO-QPL (Sashiko).
 - Say "overflow" instead of "headroom"; use USHRT_MAX directly instead
   of a macro (Maciej).
 - Say which trees need patch 1, for stable.
v3: https://lore.kernel.org/netdev/20261103090651.35399-1-amaan.cheval@gmail.com/
v2: https://lore.kernel.org/netdev/20261102112613.18334-1-amaan.cheval@gmail.com/
v1: https://lore.kernel.org/netdev/20261031173449.2439047-1-amaan.cheval@gmail.com/


Amaan Cheval (2):
  gve: block XDP on the DQO-QPL queue format
  gve: fix RX page refcount overflow from the pagecnt bias

 drivers/net/ethernet/google/gve/gve.h                |  2 +-
 .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c    |  4 ++--
 drivers/net/ethernet/google/gve/gve_main.c           |  6 ++++++
 drivers/net/ethernet/google/gve/gve_rx.c             |  8 ++++----
 drivers/net/ethernet/google/gve/gve_utils.c          | 12 ++++--------
 drivers/net/ethernet/google/gve/gve_utils.h          |  2 +-
 6 files changed, 18 insertions(+), 16 deletions(-)


base-commit: 21f57ec673a1917547c808cfa81890485fffa03b
-- 
2.47.3

