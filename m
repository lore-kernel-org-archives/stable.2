Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050206;
	b=4vnGSs+GSCl5BVXwWALD6iURUYipB4uA3i9EcLGyulfXdQPCA8QU7e/ZgeIwe226NNyB
	 PnPT/VmjuET3YIxdJGgKmsh3k1qpqHAG5QDCg9G8IUzpG4YdQnzlMSpFBME3GMq2a7U6b
	 vpJZBvBoXQzCTC5BlO9oQ7d9fJ8PuAlBhHZBQoTPgECJS+C9IzoiaG1tgkI4TNxDMY10O
	 w3W4D9WneHDbV6S1jLp7aoJ3k6VfL7UjZP8gb6AtIMjQF+T+YaRAJK6AmRICXD1+MybTl
	 hn3K90isUYbEjJwvVg0joaM+Bsrsh7va05ZdjANW49VVvtXdIJL+LkGTwz+QULzQ08w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050206;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2X4Z9NhGBXVcEWcBmHHrU4SiNzYVZhEntscqtdB63V8=;
	b=lrDlluOd3HFUKbz7OZYDqJ1PZEmAG44gAgNwcPz1MN5doq+hApRbUBoQQHHlYC7rZFNm
	 X0PhSvxX3oaTyNHIh8OeG+GtMe8SkWo3XhTy5uGrACnur/bw+mXnz1VJAdZDXhtPovqMO
	 CB2cOStJl6/lz1QGq15WY6+Pf0imsBezuHhUlNHL3ahc0Td3qu6RjdeSza2jxO8KV1ffs
	 SoXLzhW+hsdfy1gZTebnCYjxn3iFAzlD4qPJ8JaiPp/9PoJbvnQd0e9BHcxpH9Ayu6ZMB
	 R0zOVZHz6y8HciF6EjIlcDWlm+p4w9D+VLFPGQLwNnzt5ouponyD9Y9l6/9sBbstEAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2YRjWo1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA273606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2YRjWo1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C241F0089F;
	Sat,  7 Nov 2026 11:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050205;
	bh=2X4Z9NhGBXVcEWcBmHHrU4SiNzYVZhEntscqtdB63V8=;
	h=From:To:Cc:Subject:Date;
	b=F2YRjWo1gfI4aVsrnayz7JJxJnAigYxRGQVT35w972S5d17TYNFuVK/t9Ll2GNx/Q
	 cryX7faeO4NFtU8ymcYO4eDNiINjdIuqfd7sQUKYyrmE4P7/3OHI7JPPmuhXH1R9g+
	 zGWH2g3UFO40VM0Rv+a3yFic2Qo65y+ZTMsxTv6w8DC6P4PeaLXKxHb++/Gy0eUbe1
	 W4elpMi1/nDToiwtU0EevnHZS5BCQ+pnaGzO1+gqKef2FgNccyAuk7J4bi98Y4J/Lh
	 RsV5N/bOhGAGydHgsUHP8NPTk/pM8rgf6rHfBNy3fnnNDJ0pHHSQCgi0CqG7rJJPCp
	 qlTxFTccUiXRg==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: vpif_capture: Fix i2c adapter reference leak in vpif_probe()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:16:44 -0500
Message-ID: <20261107061644-failed-5.10-b00fbdad64d4@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b00fbdad64d4ea7d594bc67988c1722fe5b3be50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061644-failed-5.10-b00fbdad64d4@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b00fbdad64d4ea7d594bc67988c1722fe5b3be50 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Thu, 17 Sep 2026 10:12:22 +0000
Subject: [PATCH] media: vpif_capture: Fix i2c adapter reference leak in
 vpif_probe()

vpif_probe() takes a reference to the i2c adapter with
i2c_get_adapter() and passes it to v4l2_i2c_new_subdev_board(),
which does not consume it, but the reference is never released, so
it is leaked both when the probe succeeds and when it fails after
the adapter has been acquired.

Release the reference with i2c_put_adapter() on the success path
and in the probe_subdev_out cleanup, and initialise i2c_adap so
that the cleanup is a no-op when the adapter was never acquired.

Fixes: 6ffefff5a9e7 ("V4L/DVB (12906c): V4L : vpif capture driver for DM6467")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/platform/ti/davinci/vpif_capture.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/davinci/vpif_capture.c b/drivers/media/platform/ti/davinci/vpif_capture.c
index 91cb6223561a8..397f3115af5b7 100644
--- a/drivers/media/platform/ti/davinci/vpif_capture.c
+++ b/drivers/media/platform/ti/davinci/vpif_capture.c
@@ -1602,7 +1602,7 @@ vpif_capture_get_pdata(struct platform_device *pdev,
 static int vpif_probe(struct platform_device *pdev)
 {
 	struct vpif_subdev_info *subdevdata;
-	struct i2c_adapter *i2c_adap;
+	struct i2c_adapter *i2c_adap = NULL;
 	int subdev_count;
 	int res_idx = 0;
 	int i, err;
@@ -1692,9 +1692,12 @@ static int vpif_probe(struct platform_device *pdev)
 		}
 	}
 
+	i2c_put_adapter(i2c_adap);
+
 	return 0;
 
 probe_subdev_out:
+	i2c_put_adapter(i2c_adap);
 	v4l2_async_nf_cleanup(&vpif_obj.notifier);
 	/* free sub devices memory */
 	kfree(vpif_obj.sd);
-- 
2.53.0




