Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB9377A96
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946578; cv=none; b=N9RLnGKiIJckj4sEaLsZZOBR+qEvqUwB6ysfUSrFjOTzLN+/IGipGT9DrOyl37CMgUl7AsDTKCAQDixTt5x2E9opz6ImZ73pzAO8AMfrrEam+Y+sJu60AC5HcGrIAgdnCvzYe4x3UoSzEcplYWyO3TD1mVAJ8wS00JMHkjapJHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946578; c=relaxed/simple;
	bh=fBON41rkWJm+Nr5IP0+q0DD6zo5hPQEiHIFcCKvNNZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8VhC1V0uPK4HNQbWHJKJicDiZBcOpGEgzQduJAtQD7euF8PU7yGmN7es0HwgDCnT9zZpcGpzKGwPwa+A9s/6UXINtpOyisf8hivpzyqrIFGCjiYPJbyYmq+0ITfU1AoSIe3UBsCUtt6vG/pUhdqnnEFviYFwGnMTWoxjIjnpfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg; spf=pass smtp.mailfrom=gt.tech.gov.sg; dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b=RW6pOnFE; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.b="RW6pOnFE"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1517bda04a0so2272956c88.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1791946576; x=1792551376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PhtM3DINTPwMgq788UyncE7FKN56YRahvoDja7jwel0=;
        b=RW6pOnFE8abbsuBRK5RCPD7ELppHLMzg+X7ZUKEx9vSBE90iHPR1fl8sq681saoCLj
         Do680ch5lbDWX4cTJ2uPSRqivtGuSERxUGEmSPnOiOGmZLu50NkBi2lxkElXwl/KhYE7
         aMTQn3fpnG5a0gWvSeZVVKcQq+1bda9ttJ+Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791946576; x=1792551376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PhtM3DINTPwMgq788UyncE7FKN56YRahvoDja7jwel0=;
        b=vf9ruSzPd76CsNEHOIifVOyANXcCO8xFRaau9iedve0FLXdGUqjqFGez7FOmkJRI2r
         GnQgRcas3L/ZneJ765SKdN6SCyGZEW01woZXeTmSU6HdiCV7HBjTk9m717gJnWuLt1Jd
         vEtXj7X5Nagyy4Eeky/c6m11g36VW+dW8vmpVMigkR1NoaLDz82f0HtW8Unjh656Q6KR
         6Bod+wtMz0ilm+BE1ORxcRP587hSelqdBqVbg0DaNe5FNKtZ3craqTU0PanXRpCNbhYt
         TC2Y4CkYAM0+IQfAaAzU2uUmVgAAmFyi3oucEeduAH53sbVstZy2tnoHeAhE3RWhW3Wi
         6mxg==
X-Forwarded-Encrypted: i=1; AKwUvByihZZuCoNhxMynPcjJ2EY7gLxj9BFr2avoZ4EHNHFK5XuBAnBDY23at/tefzgW3Fw+kpIl8zI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjciWr7QexsNiFp6hXg3YSeuYqi3OAk4EBFor5PdKOXzmWypBt
	tq0Mfo4k/H/SKeJEigKSgMlgXTepBceuk2go65Cyg1zDXX76V+TvLZ/hQJpKr1BRCqPWHtMuX6L
	dXo4EcG0=
X-Gm-Gg: AYBFou2x0og2qFFfmHKdhQmr0fz9Q802BwfWav3M+MEwwIN/Lwo+H7FgS1T+aN2MO8f
	wmwHeeWMN9mohhNhz1BZYOy8fteaFU0sbZekT1y+HXRDHg/+RxvC/xTTimMahkJZ1Z/rIn2EHsx
	pnlxSn36nmVulDt8+cqsGuebRFyL67zDpqiEEN+vrnf1apqI60aIXOQn50NWrVCpPu0sa08zu2v
	c6DjfOMbNMLMRPBZkBNbo7kj5YYfr+JJVuurC78gihoHfIj6KptpnMVnH758kboAMPA5v7fQ9YD
	M7jyKHMFmPGQXfpcrY4PxXIbXHCvI7rgSrMt3rFT1tpVc4p5nuoHNedGSApbPATG6Wd/4e+zn9n
	FU1BCXWAvPEadEtjsJI79hsIZ9xENyf0cM6QVdpawTQnwwofQe0sJ8GkxS9Abn+f/MsJiP8T+Yo
	Je2pkwLTMExsZuQjUMqXs5P0taXMZvXPAPc11kDzDhsZnV4LfvMVr59Jes2K+6hB4VXwgS5Gtyq
	36ho12ckxm/tEX39Mg8IHs7GG2kVjG3NZ9BjQ==
X-Received: by 2002:a05:701b:424b:10b0:144:e246:a0b5 with SMTP id a92af1059eb24-16a5e968b0dmr19796817c88.40.1791946575008;
        Tue, 13 Oct 2026 19:56:15 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-17dc865cbffsm2122640c88.6.2026.10.13.19.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:56:14 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: usb: lan78xx: do not update statistics after a failed read
Date: Wed, 14 Oct 2026 10:56:01 +0800
Message-ID: <20261014025602.26334-2-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014025602.26334-1-law.wei.jie@gt.tech.gov.sg>
References: <20261014025602.26334-1-law.wei.jie@gt.tech.gov.sg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lan78xx_update_stats() reads the hardware counters into an on-stack
struct lan78xx_statstage. If lan78xx_read_stats() fails, only the
rollover check is skipped: the counters are still recomputed from the
uninitialized stack buffer and stored in dev->stats.curr_stat, which is
then reported to user space by ethtool -S.

Keep the previous values when the read fails.

Found by code review with LLM assistance. Tested together with the next
patch, which makes short reads fail: with an emulated device, ethtool -S
then keeps reporting the previous counters.

Fixes: 20ff55655a93 ("lan78xx: handle statistics counter rollover")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
---
 drivers/net/usb/lan78xx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..cb8204371f5c 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -789,11 +789,13 @@ static void lan78xx_update_stats(struct lan78xx_net *dev)
 
 	mutex_lock(&dev->stats.access_lock);
 
-	if (lan78xx_read_stats(dev, &lan78xx_stats) > 0)
+	if (lan78xx_read_stats(dev, &lan78xx_stats) > 0) {
 		lan78xx_check_stat_rollover(dev, &lan78xx_stats);
 
-	for (i = 0; i < (sizeof(lan78xx_stats) / (sizeof(u32))); i++)
-		data[i] = (u64)p[i] + ((u64)count[i] * ((u64)max[i] + 1));
+		for (i = 0; i < (sizeof(lan78xx_stats) / (sizeof(u32))); i++)
+			data[i] = (u64)p[i] +
+				  ((u64)count[i] * ((u64)max[i] + 1));
+	}
 
 	mutex_unlock(&dev->stats.access_lock);
 
-- 
2.43.0

