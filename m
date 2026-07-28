Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50F2F0C74
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206785; cv=none; b=GKIFeg0kh60Bf74zB3BtgJQhZm+Z43GIareufBfz0LtIiKXG66RbrGNFyL42APyeWHnMmlGvwIjrEklSkb1i9/TukxJ6u4HTtVHqB7XvqqmB8QWyzxl0hQ7mR2RGRdAtGrr8CU4Tad1pPW7vzDs0jNyMF8cxQyTBA+JnHEYldT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206785; c=relaxed/simple;
	bh=xRSbppI3HfXM2QOJ4o5CdN6pQp3FG+WBhKIwCJE/6p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FA58GSeJC4SBVBTd5MuJQUYTYuA+XYsp49pOmLdhIE8gcSBrM3W1Ts0skxDyI4pzmpgt6Vuyfqb32IZTr9K5irEHfycmBgVeYjIBUSMil8y5TK87rlLjTObWC6yYMgZX5uqVVmiqJIb/H7V49hIMvCxmhT+Q6VkOmCopqEWPDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww4ax6TU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww4ax6TU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145BE1F000E9;
	Tue, 28 Jul 2026 02:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785206782;
	bh=abEtBCH/TDJdIEwttDr0rfq3vaq1RuvgG+ChoeUUn5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ww4ax6TUPvey5vMwSDiCDqSoYe27nNTaWQ+y/OejDl4C/ZYnu1EPjSKHcZYcZH82v
	 OW/o0Bf27raQL71Evl6xuQZokMqy53I6KLl2kIDLnB/yedqaC/fzOXjlFlqBnItbls
	 qvSjboqJq6dEIYPopLIWOOdvcN9uzaTwH7xrP38XlNrYxNh3Ya54xQcm5JL+Ux019d
	 f7Nu6tUIPTA9LdzeG+30CFEUOQTM9wIIxNsQZJcdNZBBqjHN5xNTnRx3xgFvFfr46V
	 +wfHs0NlNkjcovuAj5i5fyVGwxfMgJ36kOfkWM3hhdoKvWkwVklknf2aij/f/JHuws
	 16+7pRpcPtATw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sashiko bot <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] Input: ims-pcu - fix race condition in reset_device sysfs callback
Date: Mon, 27 Jul 2026 22:46:20 -0400
Message-ID: <20260728024620.3054923-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072030-reference-unenvied-28bf@gregkh>
References: <2026072030-reference-unenvied-28bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 411b8c4b274737c3bf08e1e025801161603cfffc ]

The ims_pcu_reset_device() sysfs callback calls ims_pcu_execute_command()
without acquiring pcu->cmd_mutex. This can lead to data races and
corruption of the shared command buffer if triggered concurrently with
other commands.

Acquire pcu->cmd_mutex before calling ims_pcu_execute_command().

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/ims-pcu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 55d4fffda41bf2..94129af05620ea 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1173,6 +1173,8 @@ static ssize_t ims_pcu_reset_device(struct device *dev,
 
 	dev_info(pcu->dev, "Attempting to reset device\n");
 
+	guard(mutex)(&pcu->cmd_mutex);
+
 	error = ims_pcu_execute_command(pcu, PCU_RESET, &reset_byte, 1);
 	if (error) {
 		dev_info(pcu->dev,
-- 
2.53.0

