Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EBD513546
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784500; cv=none; b=qbuww4KgyZjtNmh+13qp/0IumhmIIKEitTw5GpsER3L0tsrmrkh4sAxk2VW80RJX0luYNj7t2hzvUwGmWBHqzQyYG8GnCxgiZ6RM7y65nB403v3Jt09IhYpyagBI/uvAL++vRKkrGIk/GSEzWy3uUMPXKEkfYtj+K4826s8BXcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784500; c=relaxed/simple;
	bh=zJZKQMvC1ys529AS4mRwnIJQMZ7PXCRhjNH/GOfynAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dsTpgs4FXKpV55zqKbeTd3wDAd+puHr9dvywiPdqSY3BvjPs8efrfpndWr3X6Nb/ND5103n4xinLS93EpJ6lyXxE90J3VdWGSQ0LT/aSt28ErFWf15lNnkiyuHPHfp65lIoif6pnoHQEozJHdJW5pEHIDr9W13Q5OlSiRXistfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=FNDqE/Rt; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="FNDqE/Rt"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so42294305e9.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790784491; x=1791389291; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CaDDtrGWSBNMp7ldkJ9Mq01ee6XVOof6NPuczSuozcI=;
        b=FNDqE/Rt9EpyqxjjAgkkneVHs5m+zPEP3nFkAa1e8oL7Fg5e2RPlDPdSlRjBRdY0VW
         2l7u6NDfhVMTUerTWRbED00Hw6jT+eeZEe/v8nnqojy8GEiAqxki/PIvMY95L3FwtF7P
         O+g24iV3Ykz62BWxBywpCsxJ08Q/qwex78qFJ7bvV7Xc/oIF3P3usMpGhxEjiC23w7N3
         Ob5DndFEoFOigml68IYAP/tMTBqTTMtWJke1apltV1mzcJ24qoMlfGRdaeBFosofLZy6
         gYol2HFAfM/UGiuVMZS+pG2VnOWAazwtcQjRL1LZctuJRkpbQaTGtzA+uz4l98OqiIJU
         dEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790784491; x=1791389291;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CaDDtrGWSBNMp7ldkJ9Mq01ee6XVOof6NPuczSuozcI=;
        b=QXa+YEagMyxjHMMUhjY7ViTHOdx3isAdx90pid+gub92/osKMZJ7mOIyniLoRrPJwR
         dJzcaiUG/a03xYExSIkpsTL15jKGZ53hD+iXrUF8+CJ67eC9vJoocwV7oFTxsju8oRp3
         BGcE60M7bLhkkdEjzr5PBYltuefN0BeLKljzV2hH7sgxqeWzcjHmpEyLCeadld4AaquD
         65e1vf4sRddOWFKut/ZuoGECRsh/cQpM4wfedSyoVnFf+/ApvhZc0EL8yU1NPSmiSUTJ
         jZbebP1fEJi0jPzskgwjRptvAEr5ve9Hkbx/mYdwMFtweNe0BDQLernAmHbS4dXbsr+a
         a2cw==
X-Forwarded-Encrypted: i=1; AKwUvBwUCegyoOcebeh0GCoylNfxrJuBvjWDKc97Gy89VfvodvB8M5bKQtv+3eJk/hAnVC2gkFyLHsk=@vger.kernel.org
X-Gm-Message-State: AFuF++mQQMaHU7ZZ3JdUwvbmxe65TIZb50PAfo+gP06zieURlpVSTpex
	ozf6D9OdOcskOpvje7sBvQuaASBfpoS1mFulJAUU1IpU4Tttc4+vKj24XUljVl0aq+E=
X-Gm-Gg: AYBFou3cKXQtMJVZ9S+H3to7dzhZsbA+i+xRJ4jaAJigqPzM53Vm6PHDivrhvtXpTsA
	g+kpzOulqb7HG37g0HiAiSODKxEN4GyReajNmdazrEeJInZ0rOl1sv2obRRByeln/JxZztc//nL
	xvVZDQZRg8yAuup9OckLGugUaUM1cZA9fB5vNFFOLmJv70ncqyJeDZT3FBO80wtssSynVD+DrS5
	pusem+6cVhjL4xtyViaPjjkWbs3bFnUiivVYmZYNmc+P4DMea2zuLuFWupGFgoBFyqtMmsqhKvz
	IyQdtmfZQoFFLzU1ICSuqL37z2dB3msqpohFMR4BbLIEJQSRznQj49JRMfWMcawChRtJcktXfq1
	e7Aj7T3fZdw0oTe6ZqhFw4bAQirfAecGiIQYt8Vwb7IGNlrhfMfGd3xURgGIQwtAAcGnFpBOi9e
	GR6AgCdr17dr9aM8Z4rsLHERaxwLcKKxXTJbQydEzbIYYrtked1k9o/79dDZa18K+JOrHffOOwj
	TTBdaH10VpGFO1UwQ==
X-Received: by 2002:a05:600d:82e3:b0:49f:fdca:c34d with SMTP id 5b1f17b1804b1-4a01aff3bc0mr40168695e9.8.1790784490851;
        Wed, 30 Sep 2026 09:08:10 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01eba0d3csm348905e9.6.2026.09.30.09.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:08:10 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 30 Sep 2026 20:07:45 +0400
Subject: [PATCH] PCI/pwrctrl: generic: Fix leaking array from
 of_regulator_bulk_get_all()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-pci-pwrctrl-kfree-v1-1-f09bbffd8da3@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ7CIBBA0as0s3YSSiMtXsW4EBx0bFPJUG0Tw
 t2LunyL/zMkEqYEpyaD0IcTv+aK9tCAf1znOyHfqkErbZTtFEbPGFfxi0w4BiFCdxyMbvtusEp
 D7aJQ4O33PF/+Tm/3JL98R1DKDkzCjgN1AAAA
X-Change-ID: 20260930-pci-pwrctrl-kfree-b58621738902
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264; i=alchark@flipper.net;
 h=from:subject:message-id; bh=zJZKQMvC1ys529AS4mRwnIJQMZ7PXCRhjNH/GOfynAs=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtNX65+WWP/Mfzu941zmZlS7rP0rEj86TahXffNCdct
 qgydQ+X7JjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqozwZ/hdpzbU7EyD6oHZh0YndG81Kd2a+tfh76oxC1OuXned2LM5iZGh4ubL
 TVivZzuSjrV5I9WTHxGuTO2U7+rd7HtV6Xj5XnBsA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

of_regulator_bulk_get_all() allocates the consumers array and hands it to
the caller, who is expected to free it at an appropriate time.
PCI pwrctrl never did, leading to a memory leak.

Add an explicit kfree() for the consumers array.

Cc: stable@vger.kernel.org
Fixes: 75996c92f4de ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Split out from [1] for easier application per Mark's feedback

[1] https://lore.kernel.org/all/20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net/
---
 drivers/pci/pwrctrl/generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
index d56171e0ee24..4b6cbbb52248 100644
--- a/drivers/pci/pwrctrl/generic.c
+++ b/drivers/pci/pwrctrl/generic.c
@@ -63,6 +63,7 @@ static void devm_slot_pwrctrl_release(void *data)
 	struct slot_pwrctrl *slot = data;
 
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
+	kfree(slot->supplies);
 }
 
 static int slot_pwrctrl_probe(struct platform_device *pdev)

---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20260930-pci-pwrctrl-kfree-b58621738902

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

