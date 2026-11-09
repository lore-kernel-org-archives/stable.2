Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218695;
	b=Ct7/RCFozJrSxvQuhm8NfQ8k7Cxx2sIRY66Iw1z23k8LDyzn421zjIm3qd+8obqXemgp
	 xR5WiqF4Lk2WSVVdWQjvagPh0HG8hT1Bvsc3FRxPKy7ejAhJuJbfohgI4Foso5Yl8mhe6
	 wJ+EO9bsic1TArMx2NZTFre2YPCaQopBgZtzYFFXBAbbMR+6IzG2PrrDqZMjQdxBCUgps
	 O2BxqNo9H3RjNj/L8oj2BCCbJB3hEnRqZdt1UF/vgsk9XJ/DImNJXP/CfjKa6HrL3diBS
	 jEEPQ1blhJIiNIxe+8y3y5okhS0zw3uoiJ9/K7NBOTYCel6xLkKoGjnB73T7YEINvEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TwcEd9hq63L/MyMr6mqXIO2VREbB+2vU/8nc1EkdGyQ=;
	b=KLc+CnxeY4S/IprnU3mKHx3xrI2Q7a2izmRIjHoENXdM9uIebRKFXAkMnhhD1FBZafl2
	 wfFcnyxdejyg6JwdP9CYhnFC9n0+8y0ebpuSzV4zYtOH/dIfze73CTCQMqXKSrbtTsgor
	 wnD0m8+fnSYKulNNoUPx4VTzf/1b8A7atQj+wUMCpNQA9hVw/XSxx4KgTD6MYKc0wNLvo
	 8ePt3DJganNbo0A6aAUI3LWWFmwr0y0L/4yctOrK6xsFgCggt6k8Z3KNWULzzJwVL7rKr
	 utgiqhdTtCV+ASAQJ4RqBFzUBefqFRYFWgtaM61sjQAdO0K8EbWsniu+Ki8Z3GmQqmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t7Enl3X5;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED653606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED653606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t7Enl3X5
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so1414362eec.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 02:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794218694; x=1794823494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TwcEd9hq63L/MyMr6mqXIO2VREbB+2vU/8nc1EkdGyQ=;
        b=t7Enl3X5kTALh4nfTW8Scxn/lbAgkhV8oKzFWRGakf0XIa/GEOyRgUQFpOvUefexAv
         bTU5GesXjrWZveB+4bEKyYmX7yp+wGc2F6+KUfV4HB2y/bU9ChmuPuYin4l4nXnyUCBu
         wb27Khg0SutRdG+12L6Ny//p8GUIfUPRwonDqz7OvqrpSfxdDE38PfrExL9T78YiO6a+
         9b31j1+OZZlYQA7DM+lGgapKe1fr8iuR3IYB50CqWgTAcWvE4LY7f+GQOUV/PYpyvsVy
         I/R+vhOcLUkNH/MGya+pAx3fU2H0LrbLPXxoKal+DxSEfAbT3Skp26RVs0RrfMEYuFvc
         DeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794218694; x=1794823494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TwcEd9hq63L/MyMr6mqXIO2VREbB+2vU/8nc1EkdGyQ=;
        b=ZzPiSHVhr4OL6ZDqoQbVCJKegGFHc32GvD2iKHeJdaza9k7EKxOqneyjvR8GAcdzW1
         EbFvLbpthOBH7gs4oB/L8WCipEw9Y1yoOSn0COklpLAk9+lGdFlUgFKZzeoe/WWgPFL/
         lbq2FNDkYj11DTUnZ66WNDucCw7IwOEn3+9RlqL5YzTYCLHz4inTxxJnm+8B6daORUZK
         wFbFyRR6J0AViOe22EHsE+NlSNoCFEo7QD9Huk2l1wjvUljbBgOPeupkIHNWfn9V8Hd5
         993ACXkJot+tslZCFK18YCLeITHAgt+0VEe+uQwpaJaJVWnn+mXDMUplq5Qt0cSkSmt4
         vLug==
X-Forwarded-Encrypted: i=1; AL+hErFlk6qk7gqoL+CKUyA1H9gnAtXermc6dxBuAEO1zMlaLrUsMVbFDTg5eYUhw+1XOkhG5Tlkd04=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jH99Lt/3KTl6wZHxFh0cMzyujRfm7tNanJtGvzcACAjwskn+m
	IJNS5V7fTnWNapamY3aQbpJIpUaHffn9l7FCW8L/9ATxP4y9J4Vmi0Qu
X-Gm-Gg: AYBFou2O1t90a47DVe4TnyG3QShGnRrYx0jQvMhLmoiB97jRJOERNB4nJNutgDXgevY
	jyIN/cEp6lsYLyP0Lv/lkkpL0HJstW2wn6xZ/W0/DRnrm97cREMQkrXPv5WE1dMo1LN7X5UsYFU
	k23JWV39jL/dTjjkRJq/Dua1v13oG31qlOzCI3+R9OB4KuXgh2mLstDeCTPVzQjCb3aA3GFX6Uu
	mJZYzEAjcaiL+bwdoxt5pjvq8aH5Oko9xajC+qQsZcUR5qtflPtHXtXOE3lDLC/286Q/3WEam4v
	HvTGBUd9OgQoiwCQrKO8uGKqvvek/bQt5ieDJfAmb6P3IFR9I2Hu93z49xQyzbjds3jCDrEvclr
	pegvRcKxnE61dFpuXesMdok6SOuNJG1vP9M4MARTA9RyldOGGZ//uJSDdgoEYLO2LyxzUc3Lq8u
	WYNCqPDGMLOlwmL1MgjPSLxHW71U4jNNeIiVQ/DU8YsJcM+1luTKMoM+ZY8jTkOHQl75clVe1As
	XakiSgbScTVyDipi0y0U7xuTW89r6WFzoXZwyNgPsd84DfRh2zdlg5WMrJWneet0R4n20q5VqC2
	IRX3xNIKc/r5mFWCvo90D9jSQVK5AFB/HzkUSlZCnMFa6Aes4JYThitj68lFKbcmbQ==
X-Received: by 2002:a05:693c:65d7:b0:361:6884:78b1 with SMTP id 5a478bee46e88-372570dea1fmr6321547eec.28.1794218693919;
        Mon, 09 Nov 2026 02:04:53 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:5a62:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d60absm12886710eec.26.2026.11.09.02.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:04:53 -0800 (PST)
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
Subject: [PATCH net v5 0/2] gve: fix RX page refcount overflow with the pagecnt bias
Date: Mon,  9 Nov 2026 15:34:35 +0530
Message-ID: <20261109100437.331423-1-amaan.cheval@gmail.com>
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
it. Patch 1 refuses XDP on any queue format the driver advertises no
XDP features for, which today means DQO-QPL, so patch 2 depends on it.
Trees before 6.17 still have the old check, so there patch 2 stands
alone.

Harshitha mentioned on v2 that Google would send a patch blocking XDP
on DQO-QPL; if one is already in flight I'm happy to drop patch 1 in
its favour.

v5:
 - Patch 1: check dev->xdp_features instead of queue_format, and
   reword the subject and message around that (Joshua).
 - Patch 2: name INT_MAX in the subject. No code change.
v4: https://lore.kernel.org/netdev/20261106114551.212675-1-amaan.cheval@gmail.com/
 - Add patch 1/2 blocking XDP on DQO-QPL (Sashiko).
 - Say "overflow" instead of "headroom"; use USHRT_MAX directly instead
   of a macro (Maciej).
 - Say which trees need patch 1, for stable.
v3: https://lore.kernel.org/netdev/20261103090651.35399-1-amaan.cheval@gmail.com/
v2: https://lore.kernel.org/netdev/20261102112613.18334-1-amaan.cheval@gmail.com/
v1: https://lore.kernel.org/netdev/20261031173449.2439047-1-amaan.cheval@gmail.com/

Amaan Cheval (2):
  gve: refuse XDP on queue formats without XDP support
  gve: fix RX page refcount overflow from INT_MAX pagecnt_bias

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

