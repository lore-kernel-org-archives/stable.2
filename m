Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047804;
	b=qJ+grpyTtqBSjWCJpYW+z8glg7Jty0cPizmLCGvqtFQdghjR0aFGSpGiS468rBtzbuD1
	 g7xiwavKIriN0qNXPiDq5qMkpoF1jTFDh07kSY8aLgl/5taK2qptI5qZ/212fN7ck+d1N
	 nCmuvfqs9y97QBaOuG2ix8c4t1ARFcknluHYjdY2l7UE0VQhEivZ51+vySQ9L0Dw/CRF2
	 xfS0d65mACHNCvRcKL+L4bbQq+X71wjsNfMXlZPyHqETFrXwO5zZtKTC9I7ZttHTaBtVB
	 S67uCiYunJUNmkZfYLHxs5hD5yXrAxJJG6nnE7tu41/drdsnXekSCFj0G8un23OfnTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047804;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fe1GbTzJ+TKt4vcXQA7JHhaCYbdFB3C4efCM/tjpBXQ=;
	b=TSlT5M9ZllcSYQ0xmghBwpUGIKeDMi/T2ZooIAtpmN2LIeeOCghU2VmkKIzUMx4c30gr
	 MwP2KyB+E+wNvo5MOwqMMjAZjoCRrsrHxt+T+pM4LMd2lk0oSziExQGKxJYCKvzNaA7kp
	 ROMYABvZcaylSTIj2DaeVY3A5Cnn//x3qXni0PTQDZTaIj5/fKLiytdQW4PriN2LlZijU
	 mVM5rzfAYQ6uUH+OCE0IT5FAUlG2pBP8xcNtXqmJs97pf41sc0ovdPZSUjT8ol13IKI65
	 uAC/znn6mbPZdhQGzfFwF0kO2LuCxSn/fhXeUd4PVIZ0B5qfe0+HPBncpJ8Z9V270wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k4/F2lrh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32522606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4/F2lrh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794541F0089F;
	Sat,  7 Nov 2026 10:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047804;
	bh=fe1GbTzJ+TKt4vcXQA7JHhaCYbdFB3C4efCM/tjpBXQ=;
	h=From:To:Cc:Subject:Date;
	b=k4/F2lrhaujhO8S+bO3ql6H36EK4cwyJ7aLMeNsjW1J6daYU0PD3sWKkDJCWUlmfN
	 8Hu/+ZEQ7RB4aDn40B3q4yfQxqWjn053unXEMesVbywDQOYjCwfEWXVB9Sji0RPINs
	 G7DeKeQdXliZBWiqdaDJl+qiAcwp3jWidSIH6XhsUhurJvAjasYMMmmVM6hbcvO70u
	 oAsWvhQjauG4QnHZcukM6cKtt1i57oZz2o3/yXN+P8UVDfKi/4FqlDZlSeklNCBKh4
	 C7r9fmMpMHcn4OH2stz0htJokIP6AEJyUoX9MEjx9BbivPs+++T8TIbHFwdwwbJb8G
	 idS7G+O4CAY8g==
From: Sasha Levin <sashal@kernel.org>
To: al.kochet@gmail.com,
	lis8215@gmail.com,
	paul@crapouillou.net,
	dmitry.torokhov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Revert "Input: matrix_keypad - force switch rows to input mode"" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:42 -0500
Message-ID: <20261107053642-failed-6.6-1527451f87df@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1527451f87dfe368b8ddeeb501c24ac9bde6b589
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053642-failed-6.6-1527451f87df@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1527451f87dfe368b8ddeeb501c24ac9bde6b589 Mon Sep 17 00:00:00 2001
From: Alexander Kochetkov <al.kochet@gmail.com>
Date: Fri, 2 Oct 2026 13:09:35 +0300
Subject: [PATCH] Revert "Input: matrix_keypad - force switch rows to input
 mode"

This reverts commit 01c84b03d80aab9f04c4e3e1f9085f4202ff7c29.

The commit makes every scan call gpiod_direction_input() on the row
GPIOs. On pin controllers where GPIO input and interrupt are separate
pinmux functions this switches the row pins out of interrupt mode, and
enable_row_irqs() does not switch them back: it only unmasks the
interrupts. Row interrupts then never arrive and the keypad stops
working. Seen with a matrix keypad on an Allwinner A64 board (PINE
A64-LTS); it works again with the commit reverted.

The workaround is not needed on Ingenic either: the author of the
reverted commit re-tested all available JZ47xx SoCs and they all report
the live pin state in interrupt mode, see the thread in Link.

Fixes: 01c84b03d80a ("Input: matrix_keypad - force switch rows to input mode")
Link: https://lore.kernel.org/all/4130C026-2A83-408B-836A-ECA044491C47@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Acked-by: Siarhei Volkau <lis8215@gmail.com>
Acked-by: Paul Cercueil <paul@crapouillou.net>
Link: https://patch.msgid.link/20261002100935.449473-1-al.kochet@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/matrix_keypad.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 14a13abf32720..d14d1d7274870 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -134,9 +134,6 @@ static void matrix_keypad_scan(struct work_struct *work)
 
 	memset(new_state, 0, sizeof(new_state));
 
-	for (row = 0; row < keypad->num_row_gpios; row++)
-		gpiod_direction_input(keypad->row_gpios[row]);
-
 	/* assert each column and read the row status out */
 	for (col = 0; col < keypad->num_col_gpios; col++) {
 
-- 
2.53.0




