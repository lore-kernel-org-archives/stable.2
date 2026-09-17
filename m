Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C69377541;
	Thu, 17 Sep 2026 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668023; cv=none; b=oQYzCx1y+FdESUalRLr/YjnLlzewNwKwxjvk9MnHJe9ELg77e2MJjtT/5xdayALlIMJgMqhvTh8GMTgJpKdjcDEYizIwA2pcLlIBe7GSoQihTTt3trWyq7AyOC4dR1UIMZ9u1fXI+URoT5fFv8lx6bTagPd4AYFkCJYVUu65Rt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668023; c=relaxed/simple;
	bh=rIk8Jxv4LNAXvAJYtAN3CNX8AJI0j9Xf64Fa6yn0kbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UzeHRL3cQEz82JtIb3M9dWc7hdjy3BVVdhQAp4rfP5IX2Q5b7xTCpfk8qUaKhMT72Hh6+KTet7CJhcOYa/PFYpKHWdWdIFOC2FJGKfd3ehQvme1RFXBKG+NLUhWiETqfnnrpbQNRp4qkWlsdx1AkNvbNpdC+pQDG0qHxOQnA0Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHdkCsKqxqbtuFCA--.1923S2;
	Fri, 18 Sep 2026 02:00:13 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	ogabbay@kernel.org,
	tomeu@tomeuvizoso.net,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] accel/rocket: Fix use-after-free in rocket_ioctl_create_bo()
Date: Thu, 17 Sep 2026 18:00:13 +0000
Message-Id: <20260917180013.2166025-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHdkCsKqxqbtuFCA--.1923S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4DuFWktr45tF15JF4rGrg_yoW8Jw43pa
	9xGry2yrZxK3yjgrZ7ZF4kua4rCw4akr18u348tw1rurn3ta4ft34Fkryqqr4UCrykWrWY
	qr1UJr1F9a4jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jrv_JF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28I
	cxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VU1cyCJUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAENA2qr9nB43gAAsi

If drm_gem_handle_create() fails, it takes and then releases its handle
reference internally, leaving the creator's reference as the only one
held.  The drm_gem_object_put() then drops that last reference, freeing
the object via rocket_gem_bo_free(), and the subsequent goto err makes
drm_gem_shmem_object_free() run on the already freed object.

Return directly on the error instead: the put has already released
everything the function acquired at this point, so there is nothing
left to clean up on the err path.

Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/accel/rocket/rocket_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index 91095d1b3066..521819041475 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -82,7 +82,7 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	ret = drm_gem_handle_create(file, gem_obj, &args->handle);
 	drm_gem_object_put(gem_obj);
 	if (ret)
-		goto err;
+		return ret;
 
 	sgt = drm_gem_shmem_get_pages_sgt(shmem_obj);
 	if (IS_ERR(sgt)) {
-- 
2.34.1

