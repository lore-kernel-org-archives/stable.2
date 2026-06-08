Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FB939934C;
	Mon,  8 Jun 2026 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949778; cv=none; b=q1l+Sgobjv20TtsJ3aFNLl2SNZchdQ8ix3jkhTmK7AWkPptzF4JS7xBkOvgQjqtCl+t3ebA+uCezii2uFyU582ZyA7NzilwiwAcLZEUyigYbGH5eOyWHzqT4SdtVutP2utZv87i962dlL5hLQa+VMs+lGLycCa8GL8zUnEQkmU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949778; c=relaxed/simple;
	bh=e6XnqR16Qqn0dxTRe/bupHetkng9jndoJ75CANg4n4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YU7T8AdSRhwaQFSm/Xy7hVctkXcvWl5RcZe/UQoIEnwUbeRIDnuiqUO1I0zBLQF8xyzBfuwN+Mbn8VDKkaYkN4e9ggLi0gL+Hv7xYj05q+48ySXdyg0xUxMKufoyac9eagrKBwg8gOLRKh5eLjgQmNZfM5K7syMmfEY6/t4CLmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFwB+MQP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFwB+MQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3CB1F00893;
	Mon,  8 Jun 2026 20:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949777;
	bh=A9Hqv4TlpLN9iAGI/RzzflDctnOwz1ujQS2MKeOsnD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jFwB+MQP5obdlxGybkTw8dCmvG6+eE/4+9e8wtKjbxBC2mpNg6cBgDUol2fDDjLZk
	 96UNVuWhBcVYoO33C51jQ/GSZ2HSLiW2YAwOuAJH7fzVGIKDFaLTbNPiKo4OObkWHj
	 SoTVfBzgY4qdvIquoapOUCZ5gFMW1jfVHv0LQOLrCEU7yj65NI4QnzLsMYrFdLYRwX
	 fWSAyfMidcLNN3e+kb3iuUVwJhoQPpDWcylTYOjZuwwgse3d9pfn6EHfahKg8NSI8u
	 1kpnz9FFzCuOBc8qce+ctcU0o68aK0O3wzlHfYgv6IcvYoGkxBXuk1dBjE8wKQeh44
	 Fn0hvOeMDsDQA==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@kernel.org,
	claudiu.beznea@tuxon.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 08/17] i3c: renesas: Clean DATBAS register on detach
Date: Mon,  8 Jun 2026 23:15:34 +0300
Message-ID: <20260608201543.804902-9-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608201543.804902-1-claudiu.beznea@kernel.org>
References: <20260608201543.804902-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The controller uses DATBAS registers on TX/RX logic. Clean the DATBAS
register for the detached I3C device to avoid issues.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- collected tags

 drivers/i3c/master/renesas-i3c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index f96848022c45..195c40956148 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -1047,6 +1047,8 @@ static void renesas_i3c_detach_i3c_dev(struct i3c_dev_desc *dev)
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct renesas_i3c *i3c = to_renesas_i3c(m);
 
+	renesas_writel(i3c->regs, DATBAS(data->index), 0);
+
 	i3c_dev_set_master_data(dev, NULL);
 	i3c->addrs[data->index].addr = 0;
 	i3c->addrs[data->index].i3c_dev = NULL;
-- 
2.43.0

