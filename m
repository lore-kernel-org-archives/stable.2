Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F293AD503;
	Tue,  6 Oct 2026 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280596; cv=none; b=QLKDEY+b8HST5mcJBnid0aZt8Ej/25JzWmLg1C0LhXzJsDmgzns8Zvcx1lA9UUrG/YO3v7LHx5fLGIT9/OvnfMerDeUVFOvI+tJnslETbdCY3/j1lnMxOtlSX8b8acAEsD8H0K/qt9UEUmqMgCszUVqLt4SHI49sW2/tudwB2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280596; c=relaxed/simple;
	bh=SidYHeRvhsnXBEbfKbMeKvExECvdv53TGvcDD2q60ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqWGYdIPOQv+PN/bZREh2P7WxZHcCvc8+9/vHXiGMHJR7wCwWHa9qauIvVcNeBc4YRKrRLPCDG49hqp2kVUskMF+nYh46QQDWb/GQpfKdn0yBMi5/POU6CWkGknsD5BXOWgmkV94PdsbrUPZMIYe7yK3AoJru9B6VK4EDORl2sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=N4pswb9P; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="N4pswb9P"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 50127ae4b;
	Tue, 6 Oct 2026 17:56:21 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Ravindra <ravindra@intel.com>
Cc: Jianhao Xu <jianhao.xu@seu.edu.cn>,
	Kiran K <kiran.k@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	stable@vger.kernel.org,
	Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: Re: [PATCH] Bluetooth: btintel_pcie: use managed IRQ teardown
Date: Tue,  6 Oct 2026 17:56:15 +0800
Message-Id: <20261006095615.384190-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005041457.3021139-1-ravindra@intel.com>
References: <20260930074453.2944525-1-runyu.xiao@seu.edu.cn> <20261005041457.3021139-1-ravindra@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa110a48a5403a1kunm27b8e2c03943b3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHxlKVkNIQ0hPHU5JSEsdGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=N4pswb9PXt96AaK10a8xhHX6YDCXMnXz/aJlUO6Qckm9CQFV6SlwSDl0NKDlWztER7u9h1FRSJsyzt/4Adw8x5cEo8D5zyJBttR+9smU5AMRrFX+IUcqxOFovyJDq31oMqqPlqtCujQMactLqgoc2FLWSqQWjD1AeAQT4H06dmY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=SidYHeRvhsnXBEbfKbMeKvExECvdv53TGvcDD2q60ns=;
	h=date:mime-version:subject:message-id:from;

On Mon, 5 Oct 2026 09:44:57 +0530, Ravindra wrote:
> I have tested this patch with repeated Bluetooth load/unload cycles on
> an Intel PCIe Bluetooth device and did not observe any kernel warnings
> or issues with the patch applied.
>
> Tested-by: Ravindra <ravindra@intel.com>
>
> Could you please send a v2 including the above Tested-by tag?

Thanks for testing this patch. I'll send a v2 shortly with your
Tested-by tag.

Thanks,
Runyu
