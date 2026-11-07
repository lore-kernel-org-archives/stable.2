Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047329;
	b=YHFuMdeK94c/LLWNqWMndeG49N8TiXfLL+j+yiZv89PmYK/bSQ2yYU67EviuaWgEWIKZ
	 wH/2MUEyjAirwXXsdxP1Trc3HXyVjEbSkL/qvG6KXVIjTzdxn89+S0mHnAbcKKZZOJeEu
	 5hbvPfbrOciMzOroVMnUBA6YdfYwnJsZCxprYQaTRkMqFnKcnMsi1AYJ0AurHv+gYD3uP
	 golUPLmxUWfIMX1kfmrCM+2MrMuGWD18O6aOAVWK1ymdnPWPwe9DkkPsQz7bclNMt4ZmU
	 vBg8na4GGZcJQIxAut3jiW9nKX3Qy3IRoY14qmSojOXkdh5DSfh6/HzxLnfZkRlgeGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047329;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lmKUBoy1c31n36ru+mfxjN9vZYIyzXCMu+rQOa5+L1E=;
	b=MNPQdmxFPggWK9kRY/aycgTkYXmhfwArUrOKYf8NvEyuuOUelBJiPEjjRyOlaSc1XWfa
	 v53xO2ls+Zn2U+0EveL3oah09dYmrqWCfG0FMeFojsLJxEnSk2CXMGfwbqG1pHB/Jn/F7
	 bJ7884zoGZVpeNkMPt3Pr1Uk3T/R3qm4n7mRXaAAn0XgIih2z8Y8cEwmTYSAFj+yinexp
	 NzqV0wMqkifqx1G84pkLxi4iAras/WwfRNCAtPmn4fU5l8ok5KQzaut8MsEjTbi4S+CAH
	 SCuUhmni54otgP1w+fmavXqkqihi/W/bEAcNuUDPjT5LS9Nf6DXywk6a6w2wj/tTvFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJnpvG9m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0415C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJnpvG9m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758511F0089F;
	Sat,  7 Nov 2026 10:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047328;
	bh=lmKUBoy1c31n36ru+mfxjN9vZYIyzXCMu+rQOa5+L1E=;
	h=From:To:Cc:Subject:Date;
	b=AJnpvG9ms/1CClOTrP6kAj2ohRhdWEqYOq9+QBevJ/uyy/V0XTX98gfMdIb2UhrS7
	 dUQVQXJ44bo9Aa267ZyrYFVH19G25XTHY0pvkEwGMxMRr/ySSC2SlNCLN+A8E4FmNa
	 aPbS1+P1lYbSmCIwYH5Sk02XTgipUD9BTDEFYEMpn66vmxBBoNS+DM/WUmV89HVkn1
	 FdddkVu7CfM7q4O8+xmvWmgGnioIfxsuhuV8JdiBNPUOyHNgxyE0LlUTCW6NWkGeDY
	 pggHY0EbmkfaF6wtqtU1PrPBdlqWlRFB9TVzv7XKKM0bqo+1DGZHgHMntBBFc1ndPC
	 holK6TvgIiw0A==
From: Sasha Levin <sashal@kernel.org>
To: punnaysharma805@gmail.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] staging: media: av7110: fix sp8870 initialization failure state" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:28:47 -0500
Message-ID: <20261107052847-failed-6.6-30684fa98394@kernel.org>
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
git cherry-pick -x 30684fa98394bc0eb4362282908612aab7d4dad9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052847-failed-6.6-30684fa98394@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 30684fa98394bc0eb4362282908612aab7d4dad9 Mon Sep 17 00:00:00 2001
From: Punnay Sharma <punnaysharma805@gmail.com>
Date: Sat, 8 Aug 2026 00:04:43 +0530
Subject: [PATCH] staging: media: av7110: fix sp8870 initialization failure
 state

The SP8870 DVB frontend driver prematurely flags the device as
initialized at the very beginning of the sp8870_init() routine, prior
to requesting the firmware (dvb-fe-sp8870.fw) and executing the I2C
upload sequence.

If request_firmware() times out or sp8870_firmware_upload() encounters
an I2C bus error, the function aborts and returns -EIO. However,
because `state->initialised` is already set to 1, all subsequent
invocations of `fe->ops.init()` by the DVB core will immediately return
0 (success) without attempting to load the firmware again. This leaves
the demodulator microcontroller halted and the frontend permanently dead
until the module is forcibly reloaded.

Relocate the `state->initialised = 1` assignment to the end of
sp8870_init(), ensuring the flag is only set after the firmware is
successfully uploaded and the system controller is actually restarted.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Punnay Sharma <punnaysharma805@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/staging/media/av7110/sp8870.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/av7110/sp8870.c b/drivers/staging/media/av7110/sp8870.c
index 340e4b22859d6..aecdbd87976fd 100644
--- a/drivers/staging/media/av7110/sp8870.c
+++ b/drivers/staging/media/av7110/sp8870.c
@@ -315,7 +315,6 @@ static int sp8870_init(struct dvb_frontend *fe)
 	sp8870_wake_up(state);
 	if (state->initialised)
 		return 0;
-	state->initialised = 1;
 
 	dprintk("initialising frontend...\n");
 
@@ -353,6 +352,8 @@ static int sp8870_init(struct dvb_frontend *fe)
 	sp8870_writereg(state, 0x0D00, 0x010);
 	sp8870_writereg(state, 0x0D01, 0x000);
 
+	state->initialised = 1;
+
 	return 0;
 }
 
-- 
2.53.0




