Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530991;
	b=UflQr62y0Xgje6LdP6dd1RYyx3OHzFRxEIVaWvGWNTG2SaOmLUDR+LRuoCco47P3gM7E
	 hBWU//dGL3u6UZB2l6nVBtw/i+XvPeX5s/y3y7Q7yLU5TitmBu/bxBKxDM2WsohBhhIRR
	 vXUOlhhCIKKX8X3Ta0zS3GbsOz8wv6qMB5gbJgy4/PKuZdbChXsb7b+IzOZtfmYNKIiGo
	 E5FKL4BD1nuhFNrVi0EDPMbVuh+c1JmFa1Rbl7R2h0yf/YhUGXSsVarFAa6h+znarui4U
	 rvpxg4rKbusILn/uvGYllicQRCPoFRbq97CJ2n9UqgjLZ+2IlXCkw/sIsHqMQP1SsJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530991;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lerioq4d56SPhYkjt+RCN3wpafD+rha2cfoz6Qv82Dw=;
	b=qhtzr1jeXbPY1JnfycMWGlJRgCJwXqhdcv6RmmnPgeYqXSimgnUGzl3H/Q92cik7b/tE
	 3QF0JOdTPh9cuLPyGULOv+jwp2Iwo3ddThy5EnUsdTZVjA2Ex/bwcaWX+nh1560+nusSB
	 5C8J9hC44hWhz4k6ZUYWM/fJcB+Q4OkQ2Pm77JxTs8M/VCboEojpVvgjNem3EXVMpGBqb
	 TMHAwI1b4sPPKV2TUPBnv+0I8FUqXVvVr4ho3C7KkOXVaFn8TJwM5Fd0t6/G7UVhsLvmN
	 wPgpE8pUoLET13RSY1PT7kqMs+LQytA6tE/URaZ7M9C/Lj+IEWtHEEPu7uhzhgxFmiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1Xqe5NW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A29F0606A32D;
	Fri, 13 Nov 2026 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1Xqe5NW
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 011E91F000C4;
	Fri, 13 Nov 2026 00:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794530991;
	bh=lerioq4d56SPhYkjt+RCN3wpafD+rha2cfoz6Qv82Dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P1Xqe5NWbSN3fIZBjJ4VgjIAr/miILeoBjAdI24rAPXf8HVuPXTge+5lE6YvRLAhz
	 WptsUqO1L9RYLD6FXE52445PGGJ4f/GM8A2T77BBFTkPJcLyKmeoZDdVj0JY0BekM6
	 3DCrW6Imij4bb3p8Lr+BvBe6rhxqAMHdn3F+OeBXvmhDZqPzf7rnjS67HIkKafPuUn
	 ES3X8YHcbZcjiS1RGDo0icvzW0wC3yZUFgogfvL0hskTXdIw//MQ6Z6gQ/UqkUv7Zi
	 Je4bKFSL1YpZr+Um0IGZ3axHa8AhU/97ERqN6lBfoXlxrgBAlEAzcXRdP5M/+DiD5W
	 KGsCQXZP1FP7A==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Guo Ren <guoren@kernel.org>
Cc: rcu@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	stable@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-csky@vger.kernel.org
Subject: [PATCH for-v7.5 1/5] srcu: Select IRQ_WORK for Tiny SRCU
Date: Thu, 12 Nov 2026 19:49:40 -0500
Message-ID: <20261113004946.2758197-2-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113004946.2758197-1-jfern@kernel.org>
References: <20261113004946.2758197-1-jfern@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tiny SRCU uses irq_work_queue() to start grace periods and
irq_work_sync() to wait for pending work. However, TINY_SRCU does not
select IRQ_WORK, so configurations that do not otherwise enable it
fail to link with undefined references to these functions.

Guenter reported this failure with csky tinyconfig on the 6.12 and
6.6 stable trees. Current kernels enable IRQ_WORK indirectly through
SLUB, but Tiny SRCU should declare its own dependency.

Select IRQ_WORK from TINY_SRCU to ensure that its irq_work calls are
supported independently of other configuration options.

Fixes: a6fc88b22bc8 ("srcu: Use irq_work to start GP in tiny SRCU")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/r/49da816c-8082-46f1-bb12-f0d6187bb06a@roeck-us.net/
Suggested-by: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bc9483c0b5d8..b6d3597758fc 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -56,6 +56,7 @@ config RCU_EXPERT
 config TINY_SRCU
 	bool
 	default y if TINY_RCU
+	select IRQ_WORK
 	help
 	  This option selects the single-CPU non-preemptible version of SRCU.
 
-- 
2.54.0

