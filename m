Received: from smtp-sv1.saltyming.net (smtp-sv1.saltyming.net [152.53.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA68345EA4
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791066822; cv=none; b=WOrD65cy8BOnHTPJwg5ZDeTQNfO1kq1RacX7u6nBTai5RjNVKee2TlB0PpfZJf1CprGUbqe8NUevT2MSeAyTyJJbSQ/WwxBQaFbIBdWwt1hcRPYly6q6v8SH6A/+zGRzjXI880BsYB685iqFDkYq1hOeewMaPB37sK7K9NO0ug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791066822; c=relaxed/simple;
	bh=4j2KxZ9VK/+X1+4N2cKVDN4zS9qwV6jDrfVT/Az9LMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXhixN7xb617sT7uk2HA5o+Z7nenZR9jmitB1yxukU8D8D7GPCs/dYaJn30wqC8M2moOU1RfkIZ9B96bO4o5cTENHkczROOnUHSs+mBMyhOKqaDI1AeV7h8eczXP7Qlhp/5kYm673UCXjWFWDJN+c2bAjgt3xVgwEkj6Y3l4nJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=saltyming.net; spf=pass smtp.mailfrom=saltyming.net; dkim=pass (2048-bit key) header.d=saltyming.net header.i=@saltyming.net header.b=w4tTiiUA; arc=none smtp.client-ip=152.53.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=saltyming.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=saltyming.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=saltyming.net header.i=@saltyming.net header.b="w4tTiiUA"
DKIM-Signature: v=1; a=rsa-sha256; s=saltyming-dkim-202512; d=saltyming.net; c=relaxed/relaxed;
	h=MIME-Version:Message-ID:Date:Subject:To:From:Content-Type; t=1791066819;
	x=1791671619; bh=YTIDmR7uDyYS3MzPy8IMzU6ozNqY3r0FgOdpTRPN1+M=; b=w4tTiiUA54
	awBxo7J2PZW2aWR7+jVZoxNk9+ltjDa8YV9zXn0ZRHTXf92lzXXnBw1YJ+Dlma68BNuaUKh79uu
	H8uT8XV3LlxI0r4kkDZmNG5MiRAo/vtUUzNoKn3VFjCOsemXAcz7WLOBsLMPGdYivVYJcGm3JoY
	8+JRik4hX4fj21COxBZGpUpmXwoTBu7zw1JFBOpbXTwQqHw1x9Ad9Jy0ee6Jn2T9w+jvQcGg5Q2
	giI+3q6LTIECGqu8KF5koRhuTP6WTHPF5moXuk6uheDQWzg7x+L3BfZUAIgN44xW9FamDFD22Yo
	XQJ2NzTyZFwPbt8iwbECTH+jn6JzdxWg==;
Received: by smtp-sv1.saltyming.net (SaltyMail) with ESMTPSA
	(version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256)
	(No client certificate requested)
	id 6e63955c-5af0-49aa-870e-db667f854862
	for <stable@vger.kernel.org>; Sat, 3 Oct 2026 22:32:27 +0000
X-Virus-Status: Clean
X-Security-Tags: spf_none, dkim_none, dmarc_fail, dmarc_quarantine, arc_none, av_clean, ham
From: Hamin Sung <hamin@saltyming.net>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Roy Spliet <rspliet@eclipso.eu>,
	Roy Spliet <nouveau@spliet.org>,
	Hamin Sung <hamin@saltyming.net>,
	stable@vger.kernel.org
Subject: [PATCH] drm/nouveau/fb/gt215: don't sleep with PFIFO paused during link training
Date: Sun,  4 Oct 2026 07:32:15 +0900
Message-ID: <20261003223215.59266-1-hamin@saltyming.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gt215_link_train() brackets the training with gt215_clk_pre() and
gt215_clk_post().  gt215_clk_pre() pauses PFIFO with nvkm_fifo_pause(),
which takes the FIFO lock with interrupts disabled and holds it until
gt215_clk_post().  In between, link training builds and runs PMU memx
scripts: nvkm_memx_init() and ram_exec() send messages to the PMU and
sleep until it replies.

With preemption counting enabled, which PREEMPT_DYNAMIC kernels always
have, the first memory reclock of a GT21x that needs link training (for
example after writing a pstate to the debugfs pstate file) logs:

  BUG: scheduling while atomic: kworker/1:3/256/0x00000002
  Workqueue: events nvkm_pstate_work [nouveau]
  Call Trace:
   gt215_pmu_send
   nvkm_memx_init
   gt215_ram_calc
   gt215_link_train
   gt215_ram_calc
   nvkm_pstate_work

A second report follows from ram_train_result(), which runs after
gt215_clk_post(), only because the first one reset the preemption count.
While the PMU runs the scripts, anything else that takes the FIFO lock,
such as enabling or disabling the non-stall interrupt for fence
signaling, spins with interrupts disabled on another CPU.  And if sending
to the PMU fails with -EBUSY inside the bracket, the error path skips
nvkm_fifo_start() and leaves the lock held.

Pausing PFIFO under the lock is not what keeps the engines off the
memory during training.  gt215_clk_pre() also halts PFIFO through
0x002504 and waits for the engines to go idle, which is all a normal
memory reclock relies on: the memx script that gt215_ram_calc() builds
halts PFIFO the same way before it reclocks the memory.  Let
gt215_clk_pre() skip the pause when it is not given flags, as
gt215_clk_post() already skips the matching start, and pass none from
link training.

Fixes: 7f4b961618d0 ("drm/nouveau/fb/ramnva3: Link training for DDR3")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5 sparse # max effort
Assisted-by: Claude:claude-fable-5-1 # max effort, review
Signed-off-by: Hamin Sung <hamin@saltyming.net>
---

Notes:
    Tested on a GeForce 310M (GT218, 512 MiB DDR3) with 6.18.54
    (PREEMPT_DYNAMIC, lazy) by writing "0x0f" to the debugfs pstate file after
    boot, which runs link training once:
    
      - without this patch: two "BUG: scheduling while atomic" splats, one
        from nvkm_memx_init() and one from nvkm_memx_train_result()
      - with it: none; the reclock still ends at core 625 MHz, shader
        1530 MHz, memory 789 MHz
    
    Booting with nouveau.config=NvClkMode=0x0f also trains and switches
    cleanly with the patch, and with nouveau.debug=fb=debug the training
    reports its 64 result words and the computed 0x100720/0x1111e0/0x111400
    values (30032100 02000404 00000000).
    
    When link training runs while the system is up, the interrupt handler on
    the other CPU can still read 0xffffffff from the GPU (the WARN_ON in
    nvkm_intr()) and a few dozen "fb: trapped write ... [PFIFO_WRITE]" lines
    are logged.  Both happen with and without this patch and look like host
    access while the training script blocks it; this patch does not try to
    address them.
    
    Found while setting up nouveau on that machine with an AI coding
    assistant, which also wrote the patch and ran the tests above on it;
    I have reviewed the patch and the test results.

 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c  |  7 ++++++-
 .../gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c    | 16 ++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c
index 5421200282b9..ad5167d23742 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c
@@ -303,6 +303,11 @@ calc_host(struct gt215_clk *clk, struct nvkm_cstate *cstate)
 	return ret;
 }
 
+/*
+ * Halt PFIFO and wait for the execution engines to go idle.  If @flags is
+ * not NULL, PFIFO is also paused under the FIFO lock with interrupts disabled
+ * until gt215_clk_post(), so the caller must not sleep in between.
+ */
 int
 gt215_clk_pre(struct nvkm_clk *clk, unsigned long *flags)
 {
@@ -319,7 +324,7 @@ gt215_clk_pre(struct nvkm_clk *clk, unsigned long *flags)
 	) < 0)
 		return -EBUSY;
 
-	if (fifo)
+	if (fifo && flags)
 		nvkm_fifo_pause(fifo, flags);
 
 	if (nvkm_msec(device, 2000,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c
index 3135b46cbfcd..6a93b2f164de 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c
@@ -164,8 +164,6 @@ gt215_link_train(struct gt215_ram *ram)
 	struct nvbios_M0205T M0205T = { 0 };
 	u8 ver, hdr, cnt, len, snr, ssz;
 	unsigned int clk_current;
-	unsigned long flags;
-	unsigned long *f = &flags;
 
 	if (nvkm_boolopt(device->cfgopt, "NvMemExec", true) != true)
 		return -ENOSYS;
@@ -186,7 +184,12 @@ gt215_link_train(struct gt215_ram *ram)
 
 	clk_current = nvkm_clk_read(clk, nv_clk_src_mem);
 
-	ret = gt215_clk_pre(clk, f);
+	/*
+	 * Talking to the PMU below sleeps, so do not pause PFIFO under its
+	 * lock.  gt215_clk_pre() still halts it through 0x002504, which is
+	 * all a normal memory reclock relies on as well.
+	 */
+	ret = gt215_clk_pre(clk, NULL);
 	if (ret)
 		goto out;
 
@@ -241,7 +244,7 @@ gt215_link_train(struct gt215_ram *ram)
 	nvkm_mask(device, 0x616308, 0x10, 0x10);
 	nvkm_mask(device, 0x616b08, 0x10, 0x10);
 
-	gt215_clk_post(clk, f);
+	gt215_clk_post(clk, NULL);
 
 	ram_train_result(ram->base.fb, result, 64);
 	for (i = 0; i < 64; i++)
@@ -258,12 +261,9 @@ gt215_link_train(struct gt215_ram *ram)
 	return ret;
 
 out:
-	if(ret == -EBUSY)
-		f = NULL;
-
 	train->state = NVA3_TRAIN_UNSUPPORTED;
 
-	gt215_clk_post(clk, f);
+	gt215_clk_post(clk, NULL);
 	kfree(result);
 	return ret;
 }

base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643
-- 
2.55.0


