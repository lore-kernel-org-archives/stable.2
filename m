Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D0C345EBE
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817143; cv=none; b=b15U8Sq6hCAGkqrIMnmkhygisyiboZMt21aG3QwD8q4ZY4VNzmUUahOHGdFwQ2chqDUwB+6jhvTWJlNyGI+Tqb/nvK3WVvW0ni+/T5OFMuoTAgnwuOPqk2hOCcKgkYE4TxqSVFQAYDlKIJDq5gCcm5ukAVt+drj7Dy0+2f/JwbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817143; c=relaxed/simple;
	bh=/dmSb1sJXVzVl5D2Ts3b72HjKW1jDDyYqIshDFjzrSs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EMpsjBntgQ/HD2BLi21XiVF1r0RaH3FJ7Iho1gHxoAmonUXlD1YQwXWiUG2qCk8/YFlq1MRdxNNn+xw2x5FAzjg+AjWFZtEDuCZFGyVZEjQ6IZFl+jbXEsOeWDfwefY2V7sRXz2Eilv1/F/6AAu1kqFiEf5fHgyvygUZ1Xi59LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bkWuAdHV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bkWuAdHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DCF1F0089B;
	Mon, 12 Oct 2026 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791817142;
	bh=+LLwuwJaUepqdXeoZ2H+PO2yVqwoNCi2d2opJSGGqrk=;
	h=Subject:To:Cc:From:Date;
	b=bkWuAdHVmhogkJ4Gnsuo/OwNAzq9/x2B306du5PyzkMb4aKeVThrtiZl6CRkhZgni
	 X07WYzvTTcr148p/XyLJjmx8wYkLY8DXQaYzPX8dO4YdeAnpSPYS1kxsGs5TJuUY8I
	 RIfzSrPFjx6vNUX0YSnoZfu2MwZsaH7gn9iD0fRs=
Subject: FAILED: patch "[PATCH] pmdomain: rockchip: fix clock leak on domain probe failure" failed to apply to 5.10-stable tree
To: shawn.lin@rock-chips.com,sebastian.reichel@collabora.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:58:58 +0200
Message-ID: <2026101258-shelter-salvaging-8f8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d8b3847770661b7109146e6479eeadcdab9cecf0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101258-shelter-salvaging-8f8b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d8b3847770661b7109146e6479eeadcdab9cecf0 Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin@rock-chips.com>
Date: Mon, 21 Sep 2026 14:52:51 +0800
Subject: [PATCH] pmdomain: rockchip: fix clock leak on domain probe failure

When of_clk_get() failed in the middle of the loop, the references of
the clocks acquired so far were leaked instead of being released by
the error path.

Fixes: d909072d0521 ("soc: rockchip: power-domain: use clk_bulk APIs")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 068dd4b3705e..b6b099b9ed5c 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -842,7 +842,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 			dev_err(pmu->dev,
 				"%pOFn: failed to get clk at index %d: %d\n",
 				node, i, error);
-			return error;
+			goto err_put_clocks;
 		}
 	}
 

