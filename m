Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7E0426D13
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364671; cv=none; b=jP6ier3Kr0WF8uRSgXmPqi4uT6MsEPSTU0m07POKAuDF3mWkZJ6lyDM2PtU7A+miVUV8Qfz3SunIGtaoJqhl2SDPF1S/9+7cy4YI8EoMusTTrsNTjKqhUwhBPPe2hmIN8SFF7QyNODSoscIpMwS6hIQ6RWHsTfZHnFjTMdr9Gks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364671; c=relaxed/simple;
	bh=dcxM9nciXFXskGhLl3NfboI6U82tcnMqomfNizhspnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqqBoJdNL0n4GpICcJD9/kgWjRVl328h2oXje13zPOSyb/wMwSiwBbgOWPaiaCxP9KQqk3lnlj+PBVkAhzNIxK9vbCCk8t/V/bD9ZSL+m5JWRnzUFEIf+fzEEQn7wmwwbTLt0hP4jwqgC1IKNjSVQEnccTEhDftVoyFcQRr9MFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI3BXM7H; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI3BXM7H"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-13fc403e373so2224733c88.1
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 12:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790364668; x=1790969468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/PfC+JKXiHR2gOczjEvFYMX7OwerkeM8UAQevJLjnNs=;
        b=kI3BXM7HmkiDuG2//zoA2nI+Ol8UU2sJHIknc7ZIovdBOntXpnInQ490DZNBYydjyW
         xebUnG7anUkarGF0Ob4YdsN09hsUyJJy/0cMT3WYef0l3LcaO2gE0cElySZ26kIjIe4Q
         wXp2xjpaU/9Prtv0Gl05FPGbkhMzkg93IP8fmpnp1qlKJM9ZqOcgnjPWmQDxyaXTuMo7
         uik7gL3HnVmnwy3truAy++2fTHENsVvsfZkbj51r2hyvRVcL5IOHyGfMDVXEGYRrmEMR
         tNDXXwKPyVxKVc776pGpstlU4gJkTdFr6m18kg9zBA9wb+aGVnRG2lLOBVOlkqrtFlsn
         PfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790364668; x=1790969468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/PfC+JKXiHR2gOczjEvFYMX7OwerkeM8UAQevJLjnNs=;
        b=Wv3q9KMVxDFFnNBLB7vT4y1XkZRZVrXD3Invs9lPkmOY8+vOy47CrXl1MwMPlQce4P
         M5t8Fi6fB57yXoy6gR2uVABlcipHZ4SRBeuo0M6nBpGFOTLyzwEq/5+Z745DniYPRDvj
         hdlcUfD95gJMFlsqkLMMj/nKn3E26SQV5idL7u0jb2Qd9/rVkds+1ItuR1fqV0BrWxqt
         jSgCMHT2xpswHXiXmyWh0pW5t3BY0RyT2aukgtDJhk1y1u7tUkqgFCNvcw4LkxMtDe9Z
         tG3cJ2Pfi0vHQ2tIY7lL4nk2aGkoROGzki37fMXdVqLcVHkRysFB5+58GFFjiamZnm7p
         I8Kg==
X-Forwarded-Encrypted: i=1; AKwUvBwOvpd5h6RuHsV49VgZxbt9pW0KZ2HBe28Am3C+kFXykjuNI1te3WtAGGljpaIJ/33vZjbGmKM=@vger.kernel.org
X-Gm-Message-State: AFuF++kZdNZS92lO9ocgqbEO8yw0voUSLv3p1N/vqRK0Gj7gMaNihEtb
	vSxS4ss3vUE3F1WV7jbGgPl+u1vUcyg9GLWEasUJDJVgLvsgk6d4HXZi
X-Gm-Gg: AYBFou271t7HQZ9AZfUW8pE8qNjulFqLB0sUdfEOP9s2cNtmzeyNhzHN8sGawFmWf5j
	SkZxaaVyhc/V4m31ascTnoPQdzCyemIP9nMSjQGDPjPus8mHTWZO+mo0XSHhk9jWlsh5OIH4Bqv
	Jg1/qGWGygqaSMRAvc+7HYWHQtzZfYdMI3RuT8Vevi1/uYNVcNZxhGj/D6ciLwuPSxQve6lAOcg
	Ewtg9bT4HkNTmrkQ1ylVYgAiVSQSh9R7ZIMttJJNUkei3wZiyMv53HCK5UFaL4twiO38zuTTcua
	GwKBlU0JnP8R/YPhunr1uEFzV7h1ojQiNGJvufMfscecq1gSdWKwRyv1f7mvqefRwH4dpCL4OzG
	GQE4JO/fTuBmd44oANKwjl/mokbK61P86xXZIHJrRj88xJsaj8rzhZFxyoGr3ymi25IW7Se/CDZ
	La9H99qkgDWRujzSvkHejyJohRZsouztDHCl1xM7PM3x+5LqNKxvY+N6+dQjyCPWpVG4EXWXsTa
	V6HVVk7HvA67iSUNZOxM5mRIHzQjN63XFIZAJsBIT+0YjETyRTAm0yRr4RQCeJRk4lE41pyE5OC
	FJXHMffAb7Q3LbdVuLCSbF6xWHpV5WDqE0OhIsTtQuL9aA==
X-Received: by 2002:a05:7022:1584:b0:13b:32f4:e826 with SMTP id a92af1059eb24-146ce968c47mr1007700c88.11.1790364668278;
        Fri, 25 Sep 2026 12:31:08 -0700 (PDT)
Received: from ututo.. ([2803:9810:87dd:de10:161:9095:8001:15fb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acc47ab8sm7886956c88.6.2026.09.25.12.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 12:31:07 -0700 (PDT)
From: Lucas Costa <2000.costalucas@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lucas Costa <2000.costalucas@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] spi: bcm2835: fix device_node reference leak in bcm2835_spi_setup()
Date: Fri, 25 Sep 2026 16:30:08 -0300
Message-ID: <20260925193008.127314-1-2000.costalucas@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923184450.135601-1-2000.costalucas@gmail.com>
References: <20260923184450.135601-1-2000.costalucas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_find_compatible_node() returns a device_node with its reference count
incremented, but bcm2835_spi_setup() only uses the return value to test
for a matching node in the loop and never releases it.

Declare the node with a scope-based __free(device_node) cleanup so the
reference is dropped automatically when leaving the loop body, matching
the existing __free(kfree) usage in the same function.

Fixes: e19c1272c80a ("spi: bcm2835: Restore native CS probing when pinctrl-bcm2835 is absent")
Cc: stable@vger.kernel.org
Signed-off-by: Lucas Costa <2000.costalucas@gmail.com>
---
Changes in v2:
- Use a scope-based __free(device_node) cleanup instead of an explicit
  of_node_put(), as suggested by the reviewer.
- v1: https://lore.kernel.org/all/20260923184450.135601-1-2000.costalucas@gmail.com/

 drivers/spi/spi-bcm2835.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 8f8715809c7c..23606967f7d1 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1297,7 +1297,9 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(pinctrl_compats); i++) {
-		if (of_find_compatible_node(NULL, NULL, pinctrl_compats[i]))
+		struct device_node *np __free(device_node) =
+			of_find_compatible_node(NULL, NULL, pinctrl_compats[i]);
+		if (np)
 			break;
 	}
 

base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.43.0

