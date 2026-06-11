Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03A218E91;
	Thu, 11 Jun 2026 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143692; cv=none; b=MhzGVAHw8oyQCIv3XszeLU0vv1QUDeoKfDp5NWu6PtDaQ2kXiM/oGt1DHoUM926l9cq87WcL/lL+aRbqMWwgz4jYVYUAsbq7yyS4GS4UnrWGVMtSpv+bjSxNrNFd009E9YgTCYfQThPKHlnNiVCjBeQhcaxX5Q2mjdOThvNnYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143692; c=relaxed/simple;
	bh=QxxTGAVVbJiQCDDc9kzk1FaC2BxjYt8KgvKClQ5hVbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1rJHsYC1/4OaKp/Xsy8yk+U4lObGbTbZhxDhIpqNXIEC+3xRbIThtrf694/Ae5O7XxTF3c7x++kprGFX0cfKkJzUUJnBz+x1ux3w1gyuF05zayH7V++0u4nnPDnXxlDgtuRsVA9h+4ORcl0jJC/kJx46uvYuddSMil2rYq0c0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=PUswkuEQ; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="PUswkuEQ"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 41eb56573;
	Thu, 11 Jun 2026 10:02:53 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: jacob.e.keller@intel.com
Cc: andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	dawei.feng@seu.edu.cn,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	jianhao.xu@seu.edu.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	marcin.szycik@linux.intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix memory leak in ice_lbtest_prepare_rings()
Date: Thu, 11 Jun 2026 10:02:54 +0800
Message-Id: <20260611020254.308446-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00f5f6e3-e80f-4c16-8d2f-f8148bcddfa8@intel.com>
References: <00f5f6e3-e80f-4c16-8d2f-f8148bcddfa8@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eb46b072103a2kunm4f921c24193a19
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTkJKVh9NGkkZSE4aHRlJHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=PUswkuEQxvP5C6A3S2B092O9Wh4MekFk1hfTk5VwxKgi1I6czgSuBzRYEDnO3wZPmVmONgPCZ4AGzHDYk1dfkYVv1DZD/mfu2tnfMqQIIfFJapZp5LsCaqa9M5WJ/fvP9OOLyNBoPWxn97LZswaohUtIGp3sHHY2AM5J88n9z2o=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=LsfLRl7OuI64QZa7FWNmdbCqTIV71pSU3+SydKKbDjw=;
	h=date:mime-version:subject:message-id:from;

Hi Marcin,

Thanks for your review.

On Tue, 9 Jun 2026 at 16:27:20 Marcin Szycik wrote:
> IMO last two paragraphs should not be included in commit message,
> rather after ---.

The reason the manual inspection and testing commentary was placed above
the `---` line is that we were strictly following the example template
provided in Documentation/process/researcher-guidelines.rst. 

In the researcher-guidelines[1], the example explicitly places the build
and hardware testing disclaimer before the Signed-off-by tags, which is
why we included it directly in the commit message.

Please let me know if you would like a v2 to adjust the position of the
mentioned commit log details.

> Correct me if I'm wrong, but looks like unroll order is reversed:
> ice_vsi_stop_lan_tx_rings() unrolls ice_vsi_cfg_lan()
> ice_vsi_free_rx_rings() unrolls ice_vsi_setup_rx_rings()
> (was reversed before this patch too, but since we're fixing it, might as well)

You are right. I'll update it in v2.

[1] https://docs.kernel.org/process/researcher-guidelines.html

Best regards,
Dawei
