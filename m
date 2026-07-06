Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B442F37A849;
	Mon,  6 Jul 2026 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347907; cv=none; b=IRgI9nSszNlsO7oD6Kxm+JTEmYYL/yOWoDUYhokAs8945Pyw8fIWC8VatqYGLfuIwG2qTQAvWW35IXb6TcE+7hJXaIo4tcIzdOqP9N00xE1E2JZUFgQ0lG78PeZApL/Z6dOfAELK5luSUtecvDcPJPzDyMJLcxRqwGiA3X+caxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347907; c=relaxed/simple;
	bh=C2Saa5XpV03/C4HkVOGMRTqdRTVQbwGa+2F/73MPLWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Et4oyt4NIu5q6XgTjzCUR1TjWztP2RnSo7IalmT07vMZfUk2Ss6zKtF1JroLtnqynq0mtP8OXyKXKvwIX1Qs0Y1RJtunucuLfzJx9ZZVAJ2/zglQpIYiUbt1mj+2dg6XKYjrzfv4CCwxrBGsTebnTuosaSlXNjhSfDkKy+WplzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ltcHrTS6; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ltcHrTS6"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4516bc2c4;
	Mon, 6 Jul 2026 22:24:54 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: johannes@sipsolutions.net
Cc: dawei.feng@seu.edu.cn,
	jeff.johnson@oss.qualcomm.com,
	jianhao.xu@seu.edu.cn,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH net] wifi: mac80211: fix memory leak in ieee80211_register_hw()
Date: Mon,  6 Jul 2026 22:24:54 +0800
Message-Id: <20260706142454.143798-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <986fff6416ba2acd8d7a4e5fb2f6a89eb40e10d1.camel@sipsolutions.net>
References: <986fff6416ba2acd8d7a4e5fb2f6a89eb40e10d1.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f37d1571303a2kunm313b7b15960e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGh5OVh1OHh9OSR5KQ0lDGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ltcHrTS6LrY53O1dpuK+Fteeim+QCEHdmqPgnpnRt4IPML1KRoELNidIVgnQGNWdeU+uoR3ik9yJoIQdS4/b+VMkvTLplMx40KHji3+1leYzZFS1b2lBRD9fAobg/IOH9LUC+pdlWYf7v+ct7eJRdB32syJzJu91niikwTZ9Icg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=C2Saa5XpV03/C4HkVOGMRTqdRTVQbwGa+2F/73MPLWo=;
	h=date:mime-version:subject:message-id:from;

On Mon, 06 Jul 2026 13:47:22 +0200, Johannes Berg wrote:
> Reported-by? Reviewed-by?
>
>> To better align with the kernel submission guidelines, I will add a
>> "Co-developed-by:" tag in the v2 patch for Zilin to properly reflect his
>> contributions. Would this be acceptable?
>
> If he did development, I guess?
>
> Anyway you didn't do that for v2, so please resend after you figure out
> what you want :-)

Hi, Johannes,

Thank you for pointing out my omission. I will use Reviewed-by tags for
Zilin in v3 patch.

Best regards,
Dawei
