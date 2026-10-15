Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CF047D460;
	Thu, 15 Oct 2026 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792098133; cv=none; b=tgeRCkR0YCS+cAlNKs7w8NWy6qmAJpxWNsH1zwpDG7fEFgYRiR6pNTQWq8LDZ4hBkU0ec2QqN5A19I0sV3VLDOA7jRteLMvp5iWUcs+UwTSrxI/Hj7tloPrqGUB3USB6ZqDGgSc0S3h8kUR3FfUm8BIdzKsi2UQPv9ub0/9kKb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792098133; c=relaxed/simple;
	bh=QLz5+m0qx50nRJesAsedHdVkPnldEk1J4MYUE7uVWr0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Zfd9dlPCJZferL9YgUpyfrP+03yyPZTeMQD79q4mLiYjLR4nhLLN1R9KQGR+BdBZ4UihS39qggi5z870VJBYpJQiLnYEowFO6jfHZp48qMXMxpCNjUtIa7cU6TE+BB0P6JK2Ast4f68mkUm/9Kqvn3Z9EJt72zSJKbcW2ISOaK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmrxjvKQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmrxjvKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023521F000C4;
	Thu, 15 Oct 2026 21:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792098127;
	bh=j13WVM4d3/Jfut4N1phRloOMBTVGMmXlWcaLm5rqJMY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gmrxjvKQaPdYqW84TIKUoC009UfTpM2XyWpx8xdbEaN5uJjGRWkKx63fpwHPPLluK
	 ThiW5igQ7E1nS6GQzTHgSuhg6hxTc1SifvwzdZfWfnR1sKcfon3M4EkHrGe2ai+9sF
	 TO2rztwCiZH1xxQPbMTiqk/gsXb1wvEF45Cd3qYHi0OvuFX5i5EO22Pv9JHwti9WXH
	 DGXG4yzxzqGRuZsjNYIqCdX1vbKpJlsXX3d1Jt/h7KJ8J3+XD5BpeCfXqAsKXAb7mD
	 OFlsh5xVB9pJ9mINu6a76URIG4BLz2vE6nOdXl2cszjaV7vxidRw89VCdn/TEBfHZg
	 M3pLjZJQe2GwQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, kamal.dasu@broadcom.com, 
 Weibin Liu <liuwb@xiaopeng.com>
Cc: bbrezillon@kernel.org, bcm-kernel-feedback-list@broadcom.com, 
 linux-kernel@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261015-bcm-qspi-dummy-bytes-v1-1-c319da3c2497@xiaopeng.com>
References: <20261015-bcm-qspi-dummy-bytes-v1-1-c319da3c2497@xiaopeng.com>
Subject: Re: [PATCH] spi: bcm-qspi: reject oversized dummy bytes in mspi
 exec_mem_op
Message-Id: <179208827476.134795.4412525352268497198.b4-ty@b4>
Date: Thu, 15 Oct 2026 19:17:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QLz5+m0qx50nRJesAsedHdVkPnldEk1J4MYUE7uVWr0=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIu2nt/5zmque3c7nV7FOXevshtviTP8OPmNH7XdYf/b
 glIKhRM7yhhYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBE3n5kZDjlxFJY5njqbuQX
 E+99q998td7wmcGiWU37cJimgOSXwvMMP9ZrfZ375eabBe6Xv22xdI1/+eOs3kXnblMNozsREoX
 3WAE=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 15 Oct 2026 10:16:12 +0800, Weibin Liu wrote:
> spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op
      https://git.kernel.org/broonie/spi/c/9e44f0df3fff

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

