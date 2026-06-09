Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37C6315D33;
	Tue,  9 Jun 2026 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997753; cv=none; b=Uwl8MAAjaJWq2Oy64QGZA+v6Lf7upB0qxxuuhPo+XNo/av3fyljMoDtQR09lzAsA0ltZCVOKRyNlPphxLG7vEJCLqTk+gn4trh+NjDRikm9KGw6IgcqOwXvAoxigSbChEx11jhmCT4ehiusWGUvwrlaj0NCs0npYpiAQ+cLdX3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997753; c=relaxed/simple;
	bh=OJgck8vcQ4MGVpurBxcbyHOd3yjxdbhWfjRQGMPyK5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lP/gABsUxwN9at9wwUffKtg3UP7Kn/RBKZiwuSggT4x10lCo2YR7Bhq1BBbkwuzDXBCyqdDZ72ZL/djU3C6NXv7XxoUDrflwOJ3AVb45Ph98RNVGXpAv4TQw/b3rD09hh8GFXuK7Z+lPMF604yGBBdSZHe+8mGa+M4feL+h1H9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jcwUw8hE; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jcwUw8hE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780997688;
	bh=FjDzXjUTCA7PwSwSBXMojIa1RoXXpb1tpWd5EIt2Ab4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=jcwUw8hEitQ+FishR+C+7uZGrcGsiqJjj8Rl86HK9RwRfTT1zcCNe9MABWF/gr04I
	 dDnQ5TLePayFMb9Afv8jIMgyCDa2UkaL8SRT5FKxn5L2hFVN4C0p8xTJNHGRSIvHda
	 ffPxjDfRskRXS2nnseDIHl3HrGaaa8AP5Sgussr4=
X-QQ-mid: esmtpsz17t1780997669tdd1d19f3
X-QQ-Originating-IP: C6dundOe4PtpDR286kbXAMfUPpshvmFDRxoPxnzgjVo=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 09 Jun 2026 17:34:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13231379526503889838
EX-QQ-RecipientCnt: 11
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	ZhaoJinming <zhaojinming@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] accel/rocket: Fix error path handling in rocket_job_run()
Date: Tue,  9 Jun 2026 17:33:45 +0800
Message-Id: <20260609093346.380396-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260608103845.6F4AB1F00893@smtp.kernel.org>
References: <20260608103845.6F4AB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MZ9X7MyfBLbly0P1lyM1Fzp8f5GsQImat8BBywc8CBR7YgJW0mZoiOtD
	NlcWKK6CbM+XJ+3fGmoQQRlSY3Ou1SmcP4eA+E74PbJippCNb1N+JEyY5IcDm/pHbW9EOBi
	3T+sjPwN0CRbAbtmMvU0LN2kUEx0rSEWlNfjK7wOkKvcbkc/VY2m75+hM23H9WoHzCW4Tfd
	/++LvIESssrskD0JxgLL+SOuiq6sifTScQsHHv10wnsBD0mABAHrI3TtsxOn0ZPFy8vekdq
	Bjh9FPhooFcQhG9/7Ltn8lLfB3vygXiDO6x4NjijO19LL49GRK37XM5DH6aHUN08bSfiXqy
	JSz3sBTswgG3vz0F7XT40xQZ+KCBlqrJZitstaVuzxQac/xnUnobVcuMItoiKyUKln535lH
	WmGoNKFuVaeBBQ/RchCvhTTG4lyZgXLA1lmrfDUniZf/7uIbQ0ZGIOJ85IiQ0OMttvASl6K
	EO6hFzMK+zh/hq8rIvCaam9jPQR7sDoUmOAa2+76iYYCTXgJ83IWPY62VDGA1W2B9xyhb5B
	boYMuIX6dqt6nCsHRdfXHeCU+7MX8yMMkfMLuKeRLdxbAZSkB5L3tvRRs7tCDLa8XLqI+Tb
	vvwczA3SDW4bCVx7XnhwkmRyLr4eKquu8q0bbJdrwn4DAyO0TOVs181DDOyDKJPSesY3Qvp
	4iy+axEWmIwNphQcYtqQRH99h5o9etJ0C7sVDfo1eMsFuQzLj42+Bt02tk9FOPDgYV3qJSW
	GoFYwwF4XUgkw7Q3YENrPwXZrf/dgWO/hqHdELtlBdcH3fs/0R58bsT2aZVAeNg3E9ArtPN
	o508ayNnnKKRIoOI/C5ZPwUHa3+kfVCKFKz+77ajnT4uq8mSgitQEfGQ0H+vHMYZetsa+U0
	aRf1u8zB/wZX3fFMuQww1YF/TpqnVa2pkVjximjgdahe5/Io5DtGXtUEzHGd5AGg70zZFbP
	xhIu+GhESTSNW3YeTFSmZLPQHfzsp3iFWVBj3ZDl3FYhlfxNhhwBhZGwJsKDyc4i/G3mjjN
	q28qBmnp2v9fMAkfol8fBez9OpZrr1gkt4XYO2cQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

In rocket_job_run(), after taking an extra fence reference for
job->done_fence via dma_fence_get(), the error paths have three bugs:

- The dma_fence reference held by job->done_fence is never released,
  causing a reference leak.
- pm_runtime_get_sync() increments the usage counter even on failure,
  but the error path does not decrement it, leaking the runtime PM
  reference and preventing the NPU from suspending.
- A valid but unsignaled fence is returned to the DRM scheduler,
  which triggers WARN("Fence ... released with pending signals!")
  when the scheduler drops its reference.

Fix by replacing pm_runtime_get_sync() with pm_runtime_resume_and_get()
which auto-balances the usage counter on failure, releasing both fence
references on error, and returning ERR_PTR(ret) instead of the
unsignaled fence.

Cc: stable@vger.kernel.org
Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/accel/rocket/rocket_job.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index ac51bff39833..e8a073e22ac2 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -310,13 +310,22 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 		dma_fence_put(job->done_fence);
 	job->done_fence = dma_fence_get(fence);
 
-	ret = pm_runtime_get_sync(core->dev);
-	if (ret < 0)
-		return fence;
+	ret = pm_runtime_resume_and_get(core->dev);
+	if (ret < 0) {
+		dma_fence_put(job->done_fence);
+		job->done_fence = NULL;
+		dma_fence_put(fence);
+		return ERR_PTR(ret);
+	}
 
 	ret = iommu_attach_group(job->domain->domain, core->iommu_group);
-	if (ret < 0)
-		return fence;
+	if (ret < 0) {
+		pm_runtime_put(core->dev);
+		dma_fence_put(job->done_fence);
+		job->done_fence = NULL;
+		dma_fence_put(fence);
+		return ERR_PTR(ret);
+	}
 
 	scoped_guard(mutex, &core->job_lock) {
 		core->in_flight_job = job;
-- 
2.20.1

