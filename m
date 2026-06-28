Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4AA2D595B
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665216; cv=none; b=HnNMYwQ/K96i66Nlo9ifN2PeQMV6hQdK4jA1YIwUp8fp/R0HiXeSAn3fwjXSFfz5DZKdH4Hykt2TUpszOdapZ1tlEsfsKiu8lIDwXqTbNmwWD3Sy9j7nyZ7Jd/K7FzxAm0Naqdgh2UhnPcmR6UD0f+zEVN+milTBCOsnvfFFHPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665216; c=relaxed/simple;
	bh=MjYdBZ+KhPzdgVMG0bXdHIPbo2KyirXZvHxMLywGyQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvR+oV2j0WG8b5PPkwWlh8FJXYIreiRo+YWEdh8Ad/LnhXOxJsEUVvAK0TOzRZFZOvGSCRurahPibBYSQW+9kKxflKUsRsxzckUASumpQ7fkb8O9vgW7oqKVmNUdMxR/XibFVoGeO3F+JaW1jmcm+flLAT3Y8TLDO6v626M1cYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hmp6ujtU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hmp6ujtU"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-472055b0efaso785576f8f.2
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782665213; x=1783270013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guQ0P+X3jnAXfBbJ+Y3HO6eqQ362z84GunH538h30Ko=;
        b=Hmp6ujtUlr6x9NyJhxDWF8AgkO4aID97KWDWGPpp7Ps59FFCJH66nC0j4Q55AnsCm0
         /z46h+L+yrvB8quK6kmHn8GR2WPjxhmRFD32wZsypQC+fj05joDgDU81HjNqgCj0RDRa
         v8MdRz5LJcEZxhYoEfO5mBpluVEdrqKuglV2nOXGzguHgBOddcmVaClCVwY7bkYwlaes
         JYXzAo8RcCBSx5oudSkGHcvPMovR5hwI/k/lHfDrneSFLNEDwWjbKjb9ooCaNRncpTkY
         3f4Uvne1g7lsmM6sSi/f832pbeaxGE6hQHJilM5Ely91MIbDJS/fPitqn/bw/EslQqPf
         WXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782665213; x=1783270013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=guQ0P+X3jnAXfBbJ+Y3HO6eqQ362z84GunH538h30Ko=;
        b=Oc1SI2FZthsF2v9rCBzzz4X3cUA/Hj/WhiePHimZBpvartvUmPL4JgT+yPUTcBAHPd
         ctbFWKXVEOJ5jDeY2HaW7ONc1Ct9F/kSi6+huNk+JZKl/0wP2gCnr/knudw9UEycpgzY
         CWqGRPKxrAUYMoTjKPMyDHEj/RC0rJBz6Q0X+8IlSztpXamyaj7vg8+RmiAAFZe7Mibu
         whsTEcA4b0PAXNYiAr/5Rz3XMFj1K4+qAPqAlwK6frDmj739NEXErYic8us0szIo0e8c
         i117OZJxDGdYad4LTlxoKo9OAGJDC6dPh/l1Wi4RBiTtyzJZnEgk787XkkyRBbtutT3B
         80vg==
X-Forwarded-Encrypted: i=1; AFNElJ/XzirbAn7XHzDF8XHWnpO1xw9yzonjy7x/+TeywtuFGa+BLDnZ4ljAGk+0mu3oHZVUR9wI4UU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8ezkutgJeXRLcN+nPkGxo2Jfn9INmcixqeJqv74WKRe/1fQC
	ZlAYNUMQrF0+6RyUp3FAwvMNhifQpIxhM37eHdUd4xpxVfaxJuW02zLm
X-Gm-Gg: AfdE7cll45KwI42Um1Vr1wd1lMAel6/703UvrmlykWCEBwOaGsVu2r9ZCzRRQb1kR+O
	TqVF8cPkz2/FI7XZyryFCXx1TKRrOlPchBbrtRcojIDhrVpUBEcuW5qrYjb+cZVkFUlaiwNsdbw
	mo6scER1xFX+YBAy94g8KZBe/XH6DrZ7X41THvD+6Pa47m2wH0Xy6/W1/W2OPFYas5QOiwmRqG6
	n6c6vWok0Uy//KeLl2LvT8OVN46n80PBWjtv4THoxyXPPZdwN+GhlfdeaAsCV30DokeZoX6hQea
	+dYlPjRkcBB73Jp07ikss4a2NAeRUqL/c/3G3/QIV1+5Sa8++S0JOsuh/dLOjav14Wrh/NpAuUN
	53CGwUVxl47gs1x+6z30Voaniszc0nqs/NX9+Jdw5KBN1DT8QG2Qouv1SbuVr5X375KhglehGRc
	SS5bI0nLcYircmaifKD+Prjhwg4w==
X-Received: by 2002:a05:600c:4512:b0:492:53e2:7712 with SMTP id 5b1f17b1804b1-492668856fdmr223520725e9.21.1782665212650;
        Sun, 28 Jun 2026 09:46:52 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c285fc1sm162770715e9.1.2026.06.28.09.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:46:51 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 3/6] HID: roccat-pyra: reject short button reports
Date: Sun, 28 Jun 2026 18:46:08 +0200
Message-ID: <20260628164611.17467-3-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628164611.17467-1-alhouseenyousef@gmail.com>
References: <20260628164611.17467-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Pyra raw-event path treats every button report as a complete
five-byte structure. A malformed USB device can send a shorter report
and make profile tracking or character-device event construction read
beyond the received input buffer.

Ignore incomplete button reports before calling either helper.

Fixes: cb7cf3da0daa ("HID: roccat: add driver for Roccat Pyra mouse")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-roccat-pyra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 0d515995bb9d..df8949c17ce3 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -557,6 +557,10 @@ static int pyra_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (pyra == NULL)
 		return 0;
 
+	if (data[0] == PYRA_MOUSE_REPORT_NUMBER_BUTTON &&
+	    size < sizeof(struct pyra_mouse_event_button))
+		return 0;
+
 	pyra_keep_values_up_to_date(pyra, data);
 
 	if (pyra->roccat_claimed)
-- 
2.54.0

