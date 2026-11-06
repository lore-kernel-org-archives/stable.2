Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943903;
	b=dRcpgtfwNcVsmTnO5Zrx40Db6yO+2xtHe1kfJsiFu+f4IarAfScwpkVcmNiJ9Nk6Rmak
	 C1grAKkGHKiekuW216jIpJVdU3IzvRk2plEpwEDiGqHtAGagrATDnOHcrCFqKCR+pNxpA
	 2c+orFtF6ucogyV3EG20iuEUhQcIrjCEx6U6bUlixd/P5EdeGFVzBhZZb+Ak5go0q7Wm5
	 J36wyQ7TJiVgoYL019BO+TnqjMzjwjhZLKOv171BqTGCK/rF9nlzuzluwPqlzfDVR0Oqt
	 psGJ3saRaYobT7UB2TWYp8ONkzDKJJ6AZFkZvLhCRdzr3vfsNL1IMNAx2PEhHUqjU6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aICijDd7xJCkTfq11nR+yzRU5122aZYdbxC4LCJRnpg=;
	b=V5mAIlBqOvPkM/QqK2wbS4Ub11b6JMH1HL8XmT28zHWjs/GAu6MDQYWByx88M8827yiL
	 JmhyPikAIJ/XUwuq5mu15bzvOWkcYnJBqvOwrdkxGEQKiNRUPES+TSNpN+MBKDxKDrgbV
	 vu0b4NjPUS4ba4S+E4jSjnBfWvLhpsy4ihBSiUMeAp6jl4p7D79L/2pnqlNF9ELpcmtEL
	 8E1zceNVt98l1k6L21OTHP2wSnkuv1kmWhNzGUItMzmymoELPHsxGAZrCxcKH9bsv0whA
	 EZWqhKMPaeM8NSx7BdGXTrW8CIIu25ceo1wLv4oAPcgJOnRHHHa1fJwVY/hapSRwtdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A+XTIMuZ;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A08606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 05:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0A08606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A+XTIMuZ
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ed2bfe3252so860215ad.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 21:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793943902; x=1794548702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aICijDd7xJCkTfq11nR+yzRU5122aZYdbxC4LCJRnpg=;
        b=A+XTIMuZOsIXKHhMFKxs1APRslKsJq7nlr359txDUw7lVA7nympWDlULP9Pky2QaK+
         gpxqaN1ViX9e89SK+OIS6sywgsBbbSRJ58QWnprFSVME7mDSKOkYa75dCgcLC4r0RyYT
         5b9fSjfsINPBwj6CnsyNsAa2G7GV73PWySJRGcHfOonm3vttkntn/2BGxZVQZzi7TBOA
         yFdtzBQw8DSGwEYxrmk4P4zRzNch1ZqqjIpzBU0BMWOc9oUjV0BaQHqV0McBVYWxsnSo
         qdPojH6jFSK8SCNEcp3LmEuecxB2Csw62Oo+F+0JL73/N1eodJwHgh26Yeco9K3V4bZR
         EbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793943902; x=1794548702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aICijDd7xJCkTfq11nR+yzRU5122aZYdbxC4LCJRnpg=;
        b=DzC0bkvEhNQnWos0sJPlgNXrgzXjsZY+Hcc+9f1nTB3bXRA7GK6+8cT+OMjAxaW8Y2
         iwRixppqCkhoqNkfHVuAxiSclT0p4+Y5fa+h1Rabk7VQdat+wprCsOPMdP8jQDI23hgS
         llIofzHRcyJW9vls/4UxPn9iDkdCqc63NxtafO2Lopl63EQuJ4nOrCOxNWg6FMlvVwRl
         4oiky5bCaGUEG9uhyQBTQtcZkMH1y3/J4+02YIUY9lAkSWe1N9l5kT9KagHF+uMYtq1U
         NkTPYtxMOiFzg0bEI8gPxpDukbOo0XpzGqAVEsLgI0G2kZqWv3feHKbfFyk+517UXsWF
         nRBA==
X-Forwarded-Encrypted: i=1; AL+hErHv5/1lx4ol85m+LqqvZKyXK2acbfHbqJwk4pt/cXZxZZ9wuY0Qt9tg7K2qLSs9rCqssL/zSFE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9IBqoIRB9yY11Ij5yqOZgkZJ3RlUiwXQNqdCf0qgJnWp6C4dpX
	NvmuUq0iW9tuEiHjnWOvSwsGqY3ylpY8ePNZo8HeknE+KHS56eM3S+/6
X-Gm-Gg: AYBFou3wELiJHFSzlpp6xfaG1v9/OwWHNqXRCLX+3GzTRF4kmRMcwkOEgdC7k0G2uby
	cFGBqOVwlfCRB8nuxENKr13odoY/8FWYro8+x+fwEc6mETG/JIlC7KdFGaALiUXwAe66P2KZWG2
	ytYHI7c4SJEUl11jDDlmH0v18aryjJGGVhbnDbQNM7TH8Rz/HZRzbXpbgryVWVxawiUT1jjSH59
	DQI7OwH+Uzw8jHUqYqSCB6JZcS59Io3a6wra2b7Jr4TEZjvnLO5q8Fozo6zpqvn74s6Nnns9WKp
	unpjxkxUwRyu1IDDExyOue1cyH1ihD5zQGLz88ZSmtHQMRw9fGx4rea1DuD1hdWicjmOBkoYToX
	CPDLO3zWykBeh2MkwjVEMaIauNoOiQ92zQVmiugrkseREPLHxwJOV0G2T7xkdY9lIiHfNe/1UA7
	7Tsrgnc1gNWKcKX0N9T+dzDVqbmi/uHxY0MbM50rLbUuLTMT145JlreJ6087hmmNpUaDkZA2w9Z
	IHCA1tjFe3UHsszcpPFICgtnx/RL8cq8JD+zW7gM3ZT/8tauCtdQfKOjFCNoEzH8+C7MloSsXLY
	Ukm9QvdeU75MXWQhSk/9FHEsCdaJZ9j+dcA5S7+99addRHRh
X-Received: by 2002:a17:902:cf03:b0:2e9:7190:32e3 with SMTP id d9443c01a7336-2ed41bf64cdmr19435685ad.38.1793943901959;
        Thu, 05 Nov 2026 21:45:01 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f7cfsm1756635ad.48.2026.11.05.21.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 21:45:01 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ASoC: codecs: wcd-mbhc-v2: cancel button long-press work on deinit
Date: Fri,  6 Nov 2026 14:44:47 +0900
Message-ID: <20261106054447.2019214-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106052242.2000264-1-hj351016@gmail.com>
References: <20261106052242.2000264-1-hj351016@gmail.com>
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

wcd_mbhc_deinit() drains two of the three works embedded in struct
wcd_mbhc before freeing it - correct_plug_swch (via
wcd_cancel_hs_detect_plug()) and mbhc_plug_detect_work - but not the
button long-press delayed work mbhc_btn_dwork:

	mutex_lock(&mbhc->lock);
	wcd_cancel_hs_detect_plug(mbhc, &mbhc->correct_plug_swch);
	cancel_work_sync(&mbhc->mbhc_plug_detect_work);
	mutex_unlock(&mbhc->lock);

	kfree(mbhc);

mbhc_btn_dwork is armed from the button-press interrupt handler
wcd_mbhc_btn_press_handler() with a 400 ms delay:

	schedule_delayed_work(&mbhc->mbhc_btn_dwork, msecs_to_jiffies(400));

and its handler wcd_btn_long_press_fn() dereferences @mbhc
(container_of(), mbhc->current_plug, mbhc->jack).

wcd_mbhc_deinit() frees the MBHC interrupts first, which stops new work
from being queued, but free_irq() does not cancel a delayed work that was
already scheduled. If a button was pressed within ~400 ms of component
removal, mbhc_btn_dwork is still pending when kfree(mbhc) runs, so
wcd_btn_long_press_fn() later executes against freed memory
(use-after-free).

The freeing of mbhc was introduced by commit a5475829adcc ("ASoC: codecs:
wcd-mbhc-v2: fix resource leaks on component remove"), which switched mbhc
to kzalloc() and added the kfree(mbhc) above; the deinit path cancels
correct_plug_swch (added with the multi-button support in 0e5c9e7ff899)
and, later, mbhc_plug_detect_work (added in 0c105997eefd), but
mbhc_btn_dwork has never been cancelled there.

Use the existing wcd_mbhc_cancel_pending_work() helper, which cancels
mbhc_btn_dwork (via wcd_cancel_btn_work()) and then correct_plug_swch,
matching the other cancellation sites in this file and ensuring
mbhc_btn_dwork is cancelled before wcd_cancel_hs_detect_plug() briefly
drops mbhc->lock.

Found by code review; not runtime-reproduced (requires WCD codec hardware
and a button-press event racing component removal).

Fixes: a5475829adcc ("ASoC: codecs: wcd-mbhc-v2: fix resource leaks on component remove")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
v2:
 - Use the existing wcd_mbhc_cancel_pending_work() helper instead of an
   open-coded cancel_delayed_work_sync(), per review - it cancels
   mbhc_btn_dwork before wcd_cancel_hs_detect_plug() drops the lock and
   matches the other cancellation sites.
 - Add Fixes: tag and correct the commit history in the changelog (the v1
   reference to CVE-2023-53842 was inaccurate), per review.

 sound/soc/codecs/wcd-mbhc-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -1623,7 +1623,7 @@ void wcd_mbhc_deinit(struct wcd_mbhc *mbhc)
 	free_irq(mbhc->intr_ids->mbhc_sw_intr, mbhc);

 	mutex_lock(&mbhc->lock);
-	wcd_cancel_hs_detect_plug(mbhc,	&mbhc->correct_plug_swch);
+	wcd_mbhc_cancel_pending_work(mbhc);
 	cancel_work_sync(&mbhc->mbhc_plug_detect_work);
 	mutex_unlock(&mbhc->lock);

