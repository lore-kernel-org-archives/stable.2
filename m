Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7FC2DECBA;
	Fri, 12 Jun 2026 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781233547; cv=none; b=l8j+vN/g0rHs4W4H+Wxmmgs9I5EYxOeaUveWGe4obsyLK4qCWKVT85oYn/ej+JzScALaiHqx7N/2FYM7CWdOHdaQShpyEvMI1JM2xHqem+WBTIzIwBCD24o4f7IS36LnsR8qiL9Ja+ahzAB9agZ10opXrdGRmv7DGQyW1c/V0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781233547; c=relaxed/simple;
	bh=0dmczrNZitquCdDjYxBervx56Gg66t0NRg5mD3vRg5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNTDPu5yXtCdeOYcA9FZZHg9tV7iQyhDpD51OaoIrCOSWcUk0yHvQfqwm6Ev7LYXkk66UMroddpnc5O0FI8VQd7b0YOXlNNau/l/P/DdcHbdBRu1mQ+Z/Pt7i2kGgY2kq+1FJL3uoeT15UShpn1qz0wDR3CN6RJrPrQNuYm3pqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-01 (Coremail) with SMTP id qwCowADHbdaAdytqar1cAQ--.11058S2;
	Fri, 12 Jun 2026 11:05:38 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: WenTao Liang <vulab@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: control_compat: fix refcount leak in ctl_elem_write_user()
Date: Fri, 12 Jun 2026 11:05:34 +0800
Message-ID: <20260612030534.21562-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHbdaAdytqar1cAQ--.11058S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW8KrW8AFWUWFWrCw4rZrb_yoW8GFyxpr
	sYgrZrGFZaqrWrtFnrta109F1S9ayayFWDG3yUKw1ftr13XF1vyF1vyFyYvF45ArykG3y0
	qF4Yva4fJa43CwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjJ73P
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgQA2orLhnUDwAAs6

ctl_elem_write_user() calls snd_power_ref_and_wait() which always
increments the card's power refcount. The reference is released in the
success path after __ctl_elem_write_user(), but on error the function
returns without dropping it, resulting in a refcount leak.

Fix this by adding the missing snd_power_unref(card) before the error
return.

Cc: stable@vger.kernel.org
Fixes: a1066453b5e4 ("ALSA: control: Fix power_ref lock order for compat code, too")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 sound/core/control_compat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index d53d0182fd42..7bbf5c35f013 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -99,7 +99,7 @@ static int snd_ctl_elem_info_compat(struct snd_ctl_file *ctl,
 	err = snd_power_ref_and_wait(card);
 	if (err < 0) {
 		snd_power_unref(card);
-		return err;
+		return
 	}
 	err = snd_ctl_elem_info(ctl, data);
 	snd_power_unref(card);
@@ -345,8 +345,10 @@ static int ctl_elem_write_user(struct snd_ctl_file *file,
 	int err;
 
 	err = snd_power_ref_and_wait(card);
-	if (err < 0)
+	if (err < 0) {
+		snd_power_unref(card);
 		return err;
+	}
 	err = __ctl_elem_write_user(file, userdata, valuep);
 	snd_power_unref(card);
 	return err;
-- 
2.50.1 (Apple Git-155)

