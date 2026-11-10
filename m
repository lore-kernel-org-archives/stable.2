Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272607;
	b=yUaJwDOPUj8FLxAqzB1JF4jg7HdvuD5JJPdV7wcc4p/wM2XwTzOY8DWRQgOlWameqiTP
	 xl+BO+JWbebYxrrJQ/GPMQPtkVpfXcmPIvWuaZ6bjD6Q8bHhfwUbhV9yV/RYYKZGHzCgw
	 c62y6wHJlEwvQRjl8/4YGYcXJQCmP66dCfzaBcC5/kb2lGMKns3XWxTwmXDJKCUfmV180
	 539j7aXa/NJ5wM6FWSSZZ7oIDjBrQ3a7zWQvyvwEe02vcmxpQO+RCenx6v0fxdRHWNnnH
	 M1zVtXxiQDS1gPX41NT0OE4pdxs1+KQUzcv0N67QM18G/UIO3gUvS4WptSNuSoI6syQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272607;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KJicNjKywBzsOdKQ23ZAnWUJtT0+J2IiSLCnX35ePKE=;
	b=Kd3TfmLotiJJ407P2HosKL8ujUfqa9o7AgYQ8pdwoAeavKiKUISkSmeMNDieK7l56Zd+
	 swWsNhcLJmW5PdrCbw02C+0WJU6gX0p5QK4g3HuOE5YwYs09M1cyqN0+2G4wuL9IbDm/k
	 EfVjMGGnuFwcNsmPNlhF/9WJVHsVaZxqiR/OegntkKmIAzTJuFhbZzim6ZUnIc0gGJD7k
	 K9EH4aiSDZH6X7TZ7LNYvd1dmc+tz5xaVhKRgDvmMOYrVCVqwB7U+Uz1p1waajfDDmoEl
	 9UR0kBjX/3Lm3tkGh2Alcy24F69RLcR7+iqCsONK+j9rJbpPsTA7awY2joxZ4lGThXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTgqL+f9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961E606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTgqL+f9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B991F008A1;
	Tue, 10 Nov 2026 01:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272607;
	bh=KJicNjKywBzsOdKQ23ZAnWUJtT0+J2IiSLCnX35ePKE=;
	h=From:To:Cc:Subject:Date;
	b=hTgqL+f9ZMXYIgmT3O6mo2QMAGH4cShbE12F+7DjyvdP6qco6rgByAjt5Q4Kkixon
	 AWn/j2yExecLsui3ZTG9xqyEs4fFXeM9rGQp1vUo/95qE7+lv5mcM0FPj9yVhJmv9E
	 OpHOc6oBeNF1syoAX+6o09NKcNqp1Y0//WTNt7HUHrVdp6rXRJ2qdaALnW0RO1ttOt
	 lWY6XGToGtX6CT+/jPP4NZubYEkvtZEbqdeQEhdVTxNM4TmEswtnwwFD01w4L/4Cgk
	 75BtQiCMeuBWfoI9jxKtpawqAkR1PxuXW/I6YnLVyCZeHGRrv+H8CEiySS8hansMxG
	 MP83qWjQdkhvA==
From: Sasha Levin <sashal@kernel.org>
To: alexei.solcanu@pm.me,
	lkml@antheas.dev,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (gpd-fan) Reset both fans to automatic on duo boards" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:03:25 -0500
Message-ID: <20261109200325-failed-6.18-d1f60971fbf8@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d1f60971fbf85c243ab6c78f6535fbc88fa640ce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200325-failed-6.18-d1f60971fbf8@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d1f60971fbf85c243ab6c78f6535fbc88fa640ce Mon Sep 17 00:00:00 2001
From: Alexei Solcanu <alexei.solcanu@pm.me>
Date: Sat, 26 Sep 2026 16:11:20 -0400
Subject: [PATCH] hwmon: (gpd-fan) Reset both fans to automatic on duo boards

On boards using gpd_duo_drvdata (GPD Duo, GPD Win 5), writing
pwm1_enable=2 only returns the first fan to EC control. The second fan
keeps its last manual duty cycle, e.g. full speed after pwm1=255, so a
fan control tool that exits leaves it running at that speed.

gpd_duo_write_pwm() writes both fan registers (pwm_write and
pwm_write + 1), but switching to automatic only clears pwm_write.
Also clear pwm_write + 1, so both fans return to EC control.

Tested on a GPD Win 5 (G1618-05). Not tested on the GPD Duo.

Fixes: 0ab88e239439 ("hwmon: add GPD devices sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexei Solcanu <alexei.solcanu@pm.me>
Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>
Link: https://patch.msgid.link/20260926-gpd-fan-duo-auto-v2-1-0a2ea41ee3b5@pm.me
[groeck: Dropped obsolete 'Assisted-by: tag]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/gpd-fan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
index ed212615b2fe9..b3b75f99f5883 100644
--- a/drivers/hwmon/gpd-fan.c
+++ b/drivers/hwmon/gpd-fan.c
@@ -444,6 +444,7 @@ static void gpd_duo_set_pwm_enable(struct gpd_fan_data *data, enum FAN_PWM_ENABL
 		break;
 	case AUTOMATIC:
 		gpd_ecram_write(data->drvdata, data->drvdata->pwm_write, 0);
+		gpd_ecram_write(data->drvdata, data->drvdata->pwm_write + 1, 0);
 		break;
 	}
 }
-- 
2.53.0




