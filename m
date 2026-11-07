Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049035;
	b=y7yCDUek85ksDg0NchuhfwOInHTeXMnl2dKzKxb166PVQ+KEzqksrqMTwn2NDgB9p7Y0
	 rKkmKSLcBB5pUmWudXHiYxB2i5h3FOHzJxYZZT7ohdIRJHAs1yCz8ukwdQC5IS4XqTlzF
	 bCcxBVd07k9gj1iTrNBfjny3oHNd28af4Sf3OO+ZK2v8tlMihc+p997LiCsy6Iv22h8I8
	 9a15+AsW/Ans8a88stYx3X3NC7i1Tnedxj0btT6uQFhEZhyPzKY7BWWa+qB+v/snHUlJh
	 bABPT9DAw/KBVKdrO29EXdw2LuPiZIHbIdo4Awo2lB/GQ93ALQal56EfyuaUoaoldmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049035;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=v6EJtZZ3jQdmGd/kdV3OshYFH+txYQNqhWXuEIwp1wY=;
	b=H2RI/pjBxjmfZiO5lgi3QiK83aiIAj2ACGQa3SnDqPS86QaW1lHwuhx9zxJH0LYGGK8D
	 QBgGfg7bjeJM94cZChJOlzFcoBy9tJqpVo4RBAY8HHsgqd+ssVichdTqS4HmmEXeHlS2S
	 b49SdyW9nMGiFu9Vxye+kslasgp6EBDSQhWACh5VJkhbGrukNZtLu2D6I1BPw09uNNsqy
	 BOapzKvmRk61b+byW98mFZu6TU7jxTt6dQcyLQBCkHTZd9pyQ/wirFXpXQ9xDhDGxn2gn
	 x8uKBlTcIZMDT9Yk4eU8WLfLbOetTjzrZozsYmGg8y/IeBMeFV9mUOEMEAFnmt+F8tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKIEgiRb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059D606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKIEgiRb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4921F0089F;
	Sat,  7 Nov 2026 10:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049034;
	bh=v6EJtZZ3jQdmGd/kdV3OshYFH+txYQNqhWXuEIwp1wY=;
	h=From:To:Cc:Subject:Date;
	b=bKIEgiRbC9y8sJPhg4qIwd9kLFiZBnBeD33h1qvtp4MtmMKNBlYU4V7YIp6oOIztl
	 Ipc+4g6tBMAp94s8d6P8kh5mPy62mjEIgT1VVIFEzfzghXmjVc8WSGVr1vKZ6dApZ0
	 4ZwlA0svZ4s8I0PyOk4juSNYAkV1O+OXQy6+vdubI3JVyttj93wHkR8yO1ofZD045n
	 5UCE9p1fyL4bRv8CLiQdBB9wz6rw3i8Z3xGUaodYJ4IpxAYIvfwCtTiSbv3jrAccAd
	 rWbU3L3LfEkSZoRo62Kt97cEr5vtyvOO0FsuoAPTrdyhPvnwvRCbMhohacmoc6QWfJ
	 8bxYNqflkB04Q==
From: Sasha Levin <sashal@kernel.org>
To: esben@geanix.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	andriy.shevchenko@intel.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: light: ltr501: Power down chip if request irq fails" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:12 -0500
Message-ID: <20261107055712-failed-5.15-8a9bcd587d7d@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8a9bcd587d7d768e6c8e9fff88bb89645e412731
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055712-failed-5.15-8a9bcd587d7d@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8a9bcd587d7d768e6c8e9fff88bb89645e412731 Mon Sep 17 00:00:00 2001
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 17 Aug 2026 19:08:53 +0200
Subject: [PATCH] iio: light: ltr501: Power down chip if request irq fails

In case devm_request_threaded_irq() failed, we were leaving the chip
powered instead of powering it down again. Power down the chip switching
ALS and PS modes to standby.

Fixes: 7ac702b3144b ("iio: ltr501: Add interrupt support")
Cc: stable@vger.kernel.org
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index fa0d16890c8bf..b36bd10a02624 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1538,7 +1538,7 @@ static int ltr501_probe(struct i2c_client *client)
 						"ltr501_thresh_event",
 						indio_dev);
 		if (ret)
-			return ret;
+			goto powerdown_on_error;
 	} else {
 		indio_dev->info = data->chip_info->info_no_irq;
 	}
-- 
2.53.0




