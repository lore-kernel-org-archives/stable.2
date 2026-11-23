Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461491;
	b=2lXzSNNJg2i/f8J+ovrkNtfjlP7Q1Vnrnuio3PJc8nQoONk7cyS/NeRcZQvKQLeEqtYR
	 IZSIg3vESq86MWlt6PGdBl4HiP07pVlVGi0aHWonTVJjeZX7NmgrZBaiPkTOJen4J0blt
	 yuYUlZJx3EowXti16vu8xvZplXL69rpzeCl7CaRTkT/+zv/JI1KOMt9awpMk2vnBDzwIB
	 VEtMKzwbmX6fJKANL/gfTlV6DGrwKJ2ZHGsuJnnDS30ZiDhkmwJhg4n3Rk0g2csXFFzGo
	 FJez7WcSuBkmMqJeBDwmV4VkmLH45utY3bgfuJldDTDfimKWbXy+8Umm8Kd+SorXtmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461491;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IBiXJSABWekdEHueXqCZaNtJq+L7qTfSTNmGLEe2rKQ=;
	b=2GH9SgCrBZ8llJlkx9uWzReoyjYj14y/gSGP4/6CXPJqgK6sQM64XzfLTnktJ6Ijwl5d
	 qQHRJdfiQKTSQAOUYDtE8ceGrbspPqDxNyzsrpoMakakybLm3JXUaetOxhKn2BnX3wDb3
	 Riy6HXiW45YGOe0c8TqnLIiF05C+XsbgyzyyYAGrpfCXq0K2h1ZPvPqAotKCPTTYgsOsV
	 X37Boge8DXlgARunASiTNQZP8Z24PfociRuNbn9eESN3cDmqf6uz/mhoyJ6dR8zsnmZJ7
	 IMlRrb/sgxVgjrua2SaLaggF3zBWZdldrRO3JLvjVq0DqqaJpIXolg5djjw2cgyrlFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJ8jAQNn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A72606A31E;
	Mon, 23 Nov 2026 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJ8jAQNn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB8C1F000D2;
	Mon, 23 Nov 2026 19:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461490;
	bh=IBiXJSABWekdEHueXqCZaNtJq+L7qTfSTNmGLEe2rKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SJ8jAQNn3P2Xio/IWk8WIeR0XgOXfe4OJ8s7UOkXE2eJeRrS4ko9oJS3wx3sJ3tZj
	 WzawRRGOWRwakcjzdQK19AeBufPa6CpJIIdBYcB4q0LMwA+2p2XFCO1n/SxGntF8r5
	 Jv83kCoXz4u5e6KW8hGbBdTzCTm12Zus04OmvQSgmKgqZmXc58h0ZnmVsewvZ8xZiW
	 pj5I0vE0N7YrddsZnii4zyATP1Rmppj6lMsHjjoV20eOXXinPL2McFR7Y9gpl60GiM
	 hFxMjvdJYgBKDSlDqrLQBhqeR+LUg7KVAxZTE6TdmDEde/DbPiotub8S9jViyx3EI6
	 nFQ+3NxC1SofA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Pierre Ossman <drzeus@drzeus.cx>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 07/13] mmc: tifm_sd: Synchronise timeout handler with request completion
Date: Mon, 23 Nov 2026 19:15:51 +0000
Message-ID: <20261123191703.179283-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123191703.179283-1-lee@kernel.org>
References: <20261123191703.179283-1-lee@kernel.org>
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

tifm_sd_end_cmd() deletes host->timer with timer_delete() under
sock->lock, clears host->req to NULL, and completes the request via
mmc_request_done().  Because timer_delete() does not wait for an already
executing timer callback and tifm_sd_abort() reads the active command
opcode from host->req without holding sock->lock, a concurrent timeout
expiry can dereference a NULL or freed struct mmc_request and spuriously
eject the card after the request has already completed.

Serialise tifm_sd_abort() on sock->lock, return early if host->req has
already been cleared or the socket is being ejected, and snapshot the
command opcode and flags before releasing sock->lock prior to calling
tifm_eject().

Fixes: 91f8d0118a0e ("tifm: layout fixes, small changes to comments and printfs")
Closes: https://sashiko.dev/#/bug/linux-6535b228-4464-4a24-8fea-e969201c0f95
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mmc/host/tifm_sd.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index 28ab2526dab1..30935214d17c 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -776,12 +776,24 @@ static void tifm_sd_end_cmd(struct work_struct *t)
 static void tifm_sd_abort(struct timer_list *t)
 {
 	struct tifm_sd *host = timer_container_of(host, t, timer);
+	struct tifm_dev *sock = host->dev;
+	unsigned int opcode, cmd_flags;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sock->lock, flags);
+	if (!host->req || host->eject) {
+		spin_unlock_irqrestore(&sock->lock, flags);
+		return;
+	}
+	opcode = host->req->cmd->opcode;
+	cmd_flags = host->cmd_flags;
+	spin_unlock_irqrestore(&sock->lock, flags);
 
 	pr_err("%s : card failed to respond for a long period of time "
 	       "(%x, %x)\n",
-	       dev_name(&host->dev->dev), host->req->cmd->opcode, host->cmd_flags);
+	       dev_name(&sock->dev), opcode, cmd_flags);
 
-	tifm_eject(host->dev);
+	tifm_eject(sock);
 }
 
 static void tifm_sd_ios(struct mmc_host *mmc, struct mmc_ios *ios)
-- 
2.56.1.750.gf70dc682cf-goog

