Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228587;
	b=V/WOe1PDknVgj+aGR0jsjhdIUoFenrtGMRk2v078TfgLOcEMO+A1nqaDZ3+TJUtJ91Ff
	 BnSomuUKA5u4ptF8yvIng/ahES5knRt8JeJaynTKRdTB/Vmj+nvSYZvi+jLZEQqP68MTo
	 uW51FZWP/b7X3HqGXH/6NnGMwGGtnf3Nyb9q4iJKaSw5Xodl0bhgz5xak8M+0vDAAq2Bf
	 aJQyWWN91s3HsiW/K2yTJFnTBJuHnKQND5YSFRymr1LANGQd2+S1lU5HMTv1siEO2RonV
	 vHUVyn4mFF/3GOgpVqkdbvmntBr9vSqZagvIfvDC2MQJCdTr/fC6TFhvzA8l4gJfQdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mG9Y8k2vnChqxaqg4HKskuIcpQ6X4WU53zywg6kGBHQ=;
	b=zFk4I8oZCG+dQ7rtNmlbI0bKJRSpGTSOTHCCAw9o5bnXgIH2ywcpMFQnKboLU6vOnKl/
	 5mbmlA2h4+TxeQ7QGicIWxC9ClNodfO8i2Oxs6XZMkKrFJx4GbhGIH9nituehKN0RAgDN
	 zYeSQr3IKc0s7z1fPTR/oZ6m5j0rCC6OY+KndEttI6LHGoYGo+0xqY3aiIPRPYqVnuY70
	 syjG9dlZOapx5vKEpf4tHqNfIyBW68HysGukRTpdEyRPKL6rJ13UmR2zHvd5swMWKUH/+
	 FM9qVp87Vgl5u/VJh8CaUGtw6AIxtXLEdVrMTQFmqGT6MMAr8GadpyOR73Rhlsfh0dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oof0SMWW;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AADB606D812
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AADB606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oof0SMWW
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-845788309b4so332016a34.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 04:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794228586; x=1794833386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mG9Y8k2vnChqxaqg4HKskuIcpQ6X4WU53zywg6kGBHQ=;
        b=oof0SMWWrTw7FAV1sR7haIUYvt37AGp5bvoFIQrQqKl5y3EQHSNObrqGZoA43pTS6/
         vQ7kyrQns04frayvawgKvXrnk9MiPVvt92jHDHu9jcnmECI53hw4K1kVIzXNEhQLX6KQ
         szK/zf6NWtZOiGpPvIZlEdWYrgCNc7e/0oPsm9fnuurtXeL60+h7Jug7EoeLUoKxrLdT
         T1BTuZIVSA2vkrrBOvrJhpwQM3JonL3TONgmJu6ExAtrP//EsJb1M9piyWeHwn3yrWrh
         mevuVNdPNwX+c4Zlw6GIWl1au12qv6htBKq8z5z6DyvrsB9ZTlsRvQy0RlnTBSsJLQso
         mVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794228586; x=1794833386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mG9Y8k2vnChqxaqg4HKskuIcpQ6X4WU53zywg6kGBHQ=;
        b=MQ04uwkENm9Fr48g7P0ehwHquR+sAbCTDUURPySKIPTe6A3nNuLVyT/lKRq8Z/LNbi
         i/OCHtnXEXs7JXou3Tpd0+XpmpPM4H3LQFoFmOi+pezma0C9dallxwnWC4ds9MVD11vJ
         Cxvb+JVDtTmto/vzNezKDrg4Sono4SHjVyTlntV7thmbb19zgd2xX/UY1IPjWd1UAX9X
         d57i21yPAlouv5ca/AQJouDuaOLrcOslPO9b3Qdh6GhmV5RmAtbaQGeet5GVaCsENhKz
         vFx/8nYIdot+1H11thKPRgDUCklQyMu3lTbVcSIzS4dyKLuA7WEK1YtGTRYgRXvH5Dug
         zkvQ==
X-Forwarded-Encrypted: i=1; AL+hErEw9YTS0LlzF7G5o/P8TpzezFOq/YuNUbs70NQ1XQfmQ9U4SafICN3Cc+b3yrJCleGlNNNHI7Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z//ZVioV/IGIwP8QzFKAoUBJS50xTz7P6GlMEtwcyKtFe1FDAEL
	7BOtV08/bGh5rOs3dm98NEO3la/CWGb96BIejWcMrBC2Lc9guqqTD6t1
X-Gm-Gg: AYBFou2/+FV5MnGfd4LktFeUhSR0IaUXnMJhUAK3Ont5LBEoQyvbgOWOzvnp4J/yxcM
	HdYF6/Zp7K1ACWBaoA6N03hJGe9M/wJxzsr4qwn+nlXKnPqx2YmC0NXf7xDgkbpO+RQBrTNazMR
	oXqEo9sgqOx6lxw+1sqwPHVMhaRwxuShhKzct9udrhCx3bX0nxTBm/nA1qYlrAqLUgRI+tc0P1B
	TEkgGew+HgXP0EwG6dNWv4byZhRpV9qIu/ZF76cNcLoUB6eqv8rQ211v19ehQpY4VIQB3HyiWZ9
	0Dr3P/3hPRfVUBYFka9YR8HDDvA6T5nPpz2Cs27fcDZPqUSRDy6C0RVAlpzZIfXtFF+Va5OHz4a
	ahUIsC5ROwb7wd603VwIe1UZJNFy/oOzXj+Y8pPgrHeaYIhRNPtElv+WNwng3peDS65jB0zxV9A
	QDk18fIc6geefO5QymPFTtc1UPfFMrYcC/4HpBsG395OhrmTUmffLUoxtTfovwMW6vRhMGufD46
	aNLEUH44dblN5kw0CmyAmzVQjPtYFOlldNcvSQUze7weC2ADw0AKXW3rN2jxIVFNLAzLepAs8vw
	/7JUa5qatPnoGdD/l6jbQW/xMXeO6n9s/MYnEQHKDjMvzBxB
X-Received: by 2002:a05:6830:6810:b0:823:38f9:ea5d with SMTP id 46e09a7af769-85f5078a13cmr3054227a34.11.1794228585816;
        Mon, 09 Nov 2026 04:49:45 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f4fbce9cdsm3565509a34.20.2026.11.09.04.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:49:45 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH net] net: wwan: iosm: cancel adb_timer on cleanup to avoid use-after-free
Date: Mon,  9 Nov 2026 21:49:33 +0900
Message-ID: <20261109124933.1603575-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

ipc_imem holds five hrtimers.  ipc_imem_cleanup() cancels four of them
(td_alloc_timer, tdupdate_timer, fast_update_timer and startup_timer)
but not adb_timer.  adb_timer is armed at runtime from the MUX uplink
aggregation path (ipc_imem_adb_timer_start(), reached from the encode
path) whenever aggregation is active.

If the device is torn down (modem reset, PCIe unbind) while an
aggregation window is open, adb_timer can still be queued when
ipc_imem_cleanup() returns and ipc_imem is freed.  When it then expires,
ipc_imem_adb_timer_cb() runs container_of() on the freed ipc_imem and
queues a task against it, a use-after-free.

Cancel adb_timer alongside the other hrtimers in ipc_imem_cleanup().

Found by static analysis; not tested on real hardware (needs an Intel
M.2 7360 WWAN modem).

Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/net/wwan/iosm/iosm_ipc_imem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
index 4405c85..20f8da5 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -1239,6 +1239,7 @@ void ipc_imem_cleanup(struct iosm_imem *ipc_imem)
 	hrtimer_cancel(&ipc_imem->tdupdate_timer);
 	hrtimer_cancel(&ipc_imem->fast_update_timer);
 	hrtimer_cancel(&ipc_imem->startup_timer);
+	hrtimer_cancel(&ipc_imem->adb_timer);
 
 	/* cancel the workqueue */
 	cancel_work_sync(&ipc_imem->run_state_worker);
-- 
2.43.0

