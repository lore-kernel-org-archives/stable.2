Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795840855;
	b=R4DQLAHAHTSrOjSfF0WRh/QECy3gy+Z+5cxU9s4bZMvsdRuy65qafS+wxBnM7KIk+qO6
	 L5SKZSo3ndoGcjvUzlBvmS15FW7kS1MG41HAnR0+bXmhv7AX2jXMc/Hzsqwdm0IPmCwVT
	 4HxYma3usjt7IsMn6eAnzkpjsaOjmMgPdkMqMTYtz1BoDAvwNkRcrz0ibSNQyARxxc+zO
	 CXwSEGLJOrDoqP6E87X97qvmIdV1EeE8EuBppxHL6kNNwPEznkMPq2DrFv3le7uFJhIix
	 InCqwPh+XjvldfvyxG32Va5VT95x1RaRis84o/VNOmxYZv0R8v/qHYXFP/6xgT71rHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795840855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=44Vt/f/9Eidg4LLHAGiZfANvWFFz8txu28uEAmthn6o=;
	b=apz2ueqzX0/Bfa8UZ+DzzPkztjztVehi/b6QtjdePKHtmaXjx73AI3oPxt2zkuJcVblM
	 vq0ON9kbBmT/VO9EPUsIjngWyN4nEdMYfRIrz2ICXldMIjj+p4DvGQQYOxaX/ZmhGjlny
	 E0IFnbn6q1ijGnGfQkZbbIiLw2qBIpInoKncdNzfkVn1r+J9ysTfkl1re24NBjKRhk4B6
	 pUnncVK8XfQYYnLq5tWGKJqXmRnIkCVeHpqQcqwegMiLWR9+EjyISxLElxZOqzSiJkYjw
	 xGLC87h1PTaZ45AQ0yAxIGG16Nkhei6bcrWqe3+OKRZLf+obF//3bx+Ki1gjVLEqq+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="p/AILqY/";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C98606A31C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 04:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3C98606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p/AILqY/
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b3a42a4bcdso3658882a91.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 20:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795840854; x=1796445654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=44Vt/f/9Eidg4LLHAGiZfANvWFFz8txu28uEAmthn6o=;
        b=p/AILqY/OIBgnnXGmjW6+BbVfMlZ0LGIKESGWM7artY+c6Ooo0TKByuZ37Sk1tSOcz
         jdO1l9YpvmRQIT11jSnbuJu4MP84LQbrKa9IE61PEm2MW/TgA/IXNByHK5xal6pGz4j1
         voCL6CcyjAnLweLrvC1h0Sz+QE4+QgaF90fctw5DIDiAAiu/n2mu7nDluHKVD2beIxfW
         GL/Uk0G0/SchSC4X1YYrcCWXxVPHieCoFAKS6NYW7RT4GR66o0NDdOcHZlzkYlO1MBoX
         Tv4lewkJHN85bQvtaxQEO2VYtrPp0tNdIvSKRUSE+uoi4/Cu21i7c29YiuYOyfvgyffb
         IBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795840854; x=1796445654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=44Vt/f/9Eidg4LLHAGiZfANvWFFz8txu28uEAmthn6o=;
        b=P2vbeksRou1yQYi48laOjXLpwavDGtfGui8j+q36nmoCC39lP5zZGxx5ovoB5RQuNt
         7qa5dIFcQj+wwHwXWvWs2Kq25qi9xsCmudJw/xL3wxZdKDsSEqTi03m0W8Zgy+zE5bZK
         dNBNN0B3RkzHvJq6ABQBJGlR6qohRRP2FCZ7idrahJX2dwO2QdSKmWGTNAsXxDZOjaTk
         JlRVVNSO6+P7Usez3x4J9Cg5M0WFpUb04jSu385QIafQFXWVtL87Rj+TKSDx9ZZiX+xm
         vi/ZHsvqAJgON43HzCFVbn7Ml4v4IhDZoxMidAMywinQnhyQif0UwgvL3Dn0DOI6jVzf
         6MpQ==
X-Forwarded-Encrypted: i=1; AL+hErGObMbgZtne6aSXqesigUSzVYuFvV2Jdw16iC3L4UNRQuT/6eDv22BtXPNCy6zj1EoBjTtIpZs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hyfT7aWH/A0CjzFJi+lT45E7elZxBS9iBrmwTMbrgO0sv/X7C
	a1xYscyOa+GBhFdROlezOpAl/+HcNvjiQslp3PwpPsOBVG4I8WyTQoVV
X-Gm-Gg: AZFdTZcoyHB8GJh4/hhDCD4yeWFWToZT0eKoRuf77jPSMGQgjUz+5QPilDxQXJWm1lL
	BEawLSXrENdWlGdv+fbQouwq/0779ye7jYg9al8uID+dIsLnbFzW7r8LaBsUDcouP64uKWWXTYL
	FHKbx292ip8LSdfQEHbxgcH1zY17Yq0mnnSYfcTRecd7JAzeCrPiTatJQsA95ECTeeg1ZfhUNGX
	6ZRby6anCBbSjx4zot2eHgTuu5Nvah+dtZTwV4tMT81lv8/tS1N8utQdBnl33/Y76ILBDOKNML4
	s4LKyZuIuFow3A51G4V7A0yq8bDBevbwDw2CAhXjqZSfk2AR5bdDF9rLyZLuY8nBMdUDLn+FyHs
	msmp6bWFSMTQ+++uNqksGLMSjdlkymZY/pwHIqFPNI6f/+/dHBzJ6CW1NiyEcNAXWOIFbMRheyC
	pdrf4UJQQXwtx6sI0meFGAtZAL2rYRvAzl8zpeEYuayBbRZXtRMImrxDwN95F8ajoAqdBjr8Tmf
	5J5WV7Yw2TAW9RGdEKsbCKYXVOJDc1Qobo96PrmBr+mvATDbBHN0O/krpENV49Jgd0CZdp9RWig
	UvgkOWiwAr58V0aLIX1n9MQGKZpAJiJ4zRlyGbSccMjHIr+jsxnil1kEec7YSnubpPrijMlkLgD
	7mPTO+oVTpfFfpDP+r6O4yptSnUnOlS3KT1LrGncWggN9x0RX1EvxUMfp3/73++YYlTzW6GivO0
	kxsQ==
X-Received: by 2002:a17:90b:3810:b0:3b1:bee2:223d with SMTP id 98e67ed59e1d1-3b41c9bc27emr25837489a91.53.1795840854021;
        Fri, 27 Nov 2026 20:40:54 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm42716729a91.1.2026.11.27.20.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 20:40:53 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Rosen Penev <rosenp@gmail.com>,
	Arnaud Ebalard <arno@natisbad.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Romain Perier <romain.perier@free-electrons.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/8] crypto: cesa - clear the IRQ affinity hint before freeing the IRQ
Date: Fri, 27 Nov 2026 20:40:43 -0800
Message-ID: <20261128044050.722617-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261128044050.722617-1-rosenp@gmail.com>
References: <20261128044050.722617-1-rosenp@gmail.com>
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

Commit 8dc981ba2fad ("crypto: cesa - remove irq_set_affinity_hint")
dropped the calls that cleared the affinity hint on probe failure and
removal, on the grounds that the IRQs are devm managed. devm only calls
free_irq(), which does not clear the hint, and __free_irq() hits its
WARN_ON_ONCE(desc->affinity_hint) when it finds one still set. So
unbinding the device, or a probe that fails after the first engine's
IRQ has been requested, triggers that warning.

Clear the hint from a devm action registered right after the IRQ, so it
runs before devm frees the IRQ. Switch to irq_set_affinity_and_hint(),
which is what the deprecated irq_set_affinity_hint() wraps.

Fixes: 8dc981ba2fad ("crypto: cesa - remove irq_set_affinity_hint")
Cc: stable@vger.kernel.org
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/crypto/marvell/cesa/cesa.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/cesa/cesa.c b/drivers/crypto/marvell/cesa/cesa.c
index 564b09773507..ac4fe783735b 100644
--- a/drivers/crypto/marvell/cesa/cesa.c
+++ b/drivers/crypto/marvell/cesa/cesa.c
@@ -415,6 +415,13 @@ static void mv_cesa_release_sram(void *data)
 				   cesa->sram_size, DMA_BIDIRECTIONAL, 0);
 }
 
+static void mv_cesa_clear_affinity_hint(void *data)
+{
+	struct mv_cesa_engine *engine = data;
+
+	irq_update_affinity_hint(engine->irq, NULL);
+}
+
 static int mv_cesa_probe(struct platform_device *pdev)
 {
 	const struct mv_cesa_caps *caps = &orion_caps;
@@ -519,7 +526,16 @@ static int mv_cesa_probe(struct platform_device *pdev)
 
 		/* Set affinity */
 		cpu = cpumask_local_spread(engine->id, NUMA_NO_NODE);
-		irq_set_affinity_hint(irq, get_cpu_mask(cpu));
+		irq_set_affinity_and_hint(irq, get_cpu_mask(cpu));
+
+		/*
+		 * free_irq() warns if the hint is still set. Registered after
+		 * the IRQ, so devm clears it before the IRQ is freed.
+		 */
+		ret = devm_add_action_or_reset(dev, mv_cesa_clear_affinity_hint,
+					       engine);
+		if (ret)
+			return ret;
 
 		crypto_init_queue(&engine->queue, CESA_CRYPTO_DEFAULT_MAX_QLEN);
 		atomic_set(&engine->load, 0);
-- 
2.56.1

