Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D3652E043
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951655; cv=none; b=AH6C47ixfZ4JaGtmjBw/wc/IxFouCyT8doqMTdfdrp5HQSQKSjVvFzfgRFlBpr8uwFi4IbsCtHeMwRSKS/9mGyzjUqFeyK6CQchCth1K88uY3wtx0tj3/6Cpsa99PwcXW3uhKRlQsSe82KvvBQX2ZthbdM2He4SJziuD9rFIXK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951655; c=relaxed/simple;
	bh=M0hP2hsAfGdeNDkrMphnof8ZH1mak44iDs1dRC9AZ7E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D92bEFyebUfMKtCrdGBLrAJbMoYaUt9lH66ToHGVVTr0vbMDjFG2wp4MzpuMZj0UjD+6eaiAicPe5NYbU5LKMqWTGQvtHXnYvBrvdaTBBkG1gWmb9OLIC06eVx8BXQfpoUFDkUuUwOQmmFuQQDbMLpFMMLdPlPxDtHolX0EUirI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N8YudTr4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N8YudTr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3551F00A3D;
	Wed,  9 Sep 2026 11:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788951654;
	bh=dayCt2YR0Len1REvSo1MkIoMmoL5kw3qOgtcZ4BQpbw=;
	h=Subject:To:Cc:From:Date;
	b=N8YudTr415hsQ97mh7izsErYLXyoHQ0kDvHxCRQjv8Wn1Un5Zu6BN4sZnzWP3/fa0
	 3TqY9IngMVrJ8KXuZ3DbatpfQzsJgir5I5L/YLtP3MZZduktOzFUvU9X54ORTF9Eku
	 a655m8/ueK/izFDkWdEf7CbQFiDodg9veMfpqoME=
Subject: FAILED: patch "[PATCH] media: qcom: iris: fix runtime PM reference leaks" failed to apply to 6.18-stable tree
To: dennylin0707@gmail.com,bod@kernel.org,dmitry.baryshkov@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:53:08 +0200
Message-ID: <2026090908-wobbly-comply-f1b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f87d7eda07fca21efe4b96169ae59007db46e60e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090908-wobbly-comply-f1b3@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f87d7eda07fca21efe4b96169ae59007db46e60e Mon Sep 17 00:00:00 2001
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Mon, 8 Jun 2026 08:17:20 +0000
Subject: [PATCH] media: qcom: iris: fix runtime PM reference leaks

Use pm_runtime_resume_and_get() in iris_enable_power_domains()
to avoid leaking a runtime PM usage count on failure.

Also ensure pm_runtime_put_sync() is always called in
iris_disable_power_domains(), even when iris_opp_set_rate()
fails, so runtime PM references remain balanced.

Fixes: bb8a95aa038e ("media: iris: implement power management")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>

diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index 872bd09656b1..6d3339423eec 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -78,20 +78,21 @@ int iris_enable_power_domains(struct iris_core *core, struct device *pd_dev)
 	if (ret)
 		return ret;
 
-	return pm_runtime_get_sync(pd_dev);
+	return pm_runtime_resume_and_get(pd_dev);
 }
 
 int iris_disable_power_domains(struct iris_core *core, struct device *pd_dev)
 {
 	int ret;
+	int pm_ret;
 
 	ret = iris_opp_set_rate(core->dev, 0);
-	if (ret)
-		return ret;
 
-	pm_runtime_put_sync(pd_dev);
+	pm_ret = pm_runtime_put_sync(pd_dev);
+	if (!ret)
+		ret = pm_ret;
 
-	return 0;
+	return ret;
 }
 
 static struct clk *iris_get_clk_by_type(struct iris_core *core, enum platform_clk_type clk_type)

