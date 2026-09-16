Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8663E4AEBEF;
	Wed, 16 Sep 2026 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552149; cv=none; b=sdjGSxLfU6Unmzm5HFKeifs2+VyIsb1JsIEJ+XIiDj3SnPl1RF2XtBzJPajg0iP7CsmiaXqyREcemJoM0asTsYC6+y/7VoIYxr3yuwEEv66MmXTP/KubNz231mZxsbZFzodFqRoqjiEA6hANmCeq71ciSovAtalcIUDrg7v4iPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552149; c=relaxed/simple;
	bh=yNZKSeD9djGtz5o/sJAjhbLIc6ZrYenwtSjaIgHcp50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U8lWLRMx0SvOjKHiBsDpF0hkOjgXLN+i1N87cYQoXPMw1TV0H4sadLaLXxK4Xm+tAzQya/59S5oC/6pWV5b9bJL1KtBFFN9WBgv4X+da6Gyx0kFFSeXS19zPy93kZWbjkra/p84XsNq+coD6MDeIXUjyd/77nk/lH0NwB7ePG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXmjj9ZapqLKXgBw--.61487S2;
	Wed, 16 Sep 2026 17:48:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: axboe@kernel.dk
Cc: bvanassche@acm.org,
	danil.kipnis@cloud.ionos.com,
	haris.iqbal@ionos.com,
	jgg@ziepe.ca,
	jinpu.wang@ionos.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] rnbd-srv: Fix sess_dev use-after-free in process_msg_close()
Date: Wed, 16 Sep 2026 09:48:17 +0000
Message-Id: <20260916094817.2007756-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXmjj9ZapqLKXgBw--.61487S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1fAFW8Kr47JFy3uF17Wrg_yoW8GFyxpa
	y0y3Wj9ryFkF4UG3yDZw4xuFWYyan2y3y8Cr1xur1UZ345ZFy2vFn3X34xJF1qqry8Can0
	qFn5JayrCw1Yya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7VUbtl1PUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIMA2qqP4efBQAAs2

process_msg_close() drops the device reference with rnbd_put_sess_dev()
before using sess_dev again in rnbd_srv_destroy_dev_session_sysfs().
If that put drops the last kref, e.g. when the device is concurrently
being torn down through rnbd_srv_sess_dev_force_close(), the waiter in
rnbd_destroy_sess_dev() is woken up and frees sess_dev, so the
subsequent rnbd_srv_destroy_dev_session_sysfs() call operates on freed
memory.

Move the rnbd_put_sess_dev() call after the sysfs teardown so it is the
last access to sess_dev.

Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/block/rnbd/rnbd-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 10e8c438bb43..2ebc2eac384f 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -361,10 +361,10 @@ static void process_msg_close(struct rnbd_srv_session *srv_sess,
 	if (IS_ERR(sess_dev))
 		return;
 
-	rnbd_put_sess_dev(sess_dev);
 	mutex_lock(&srv_sess->lock);
 	rnbd_srv_destroy_dev_session_sysfs(sess_dev);
 	mutex_unlock(&srv_sess->lock);
+	rnbd_put_sess_dev(sess_dev);
 }
 
 static int process_msg_open(struct rnbd_srv_session *srv_sess,
-- 
2.34.1

