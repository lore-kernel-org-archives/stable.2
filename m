Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046061;
	b=P1ZnZndg4aR5aA8AdEOXc5hzS2nNtB1TeGOnBUQlvGaUFYyqkiysD88JH+oi3gr2g9nk
	 iUzdgAPSWYFPr4YWUITZer66cadDSbD035+CS8IGwhcANm/e75I2869ZGGx6nStpczTQi
	 xnNrWWyH3L38HXc6N6LhoGRAJyyi+jNu5pYX58j9sLqrP4SpDv1a30EUf36ygb0B0EsY6
	 0bv5OJHpvMKzBnQViQWKDhviHlLmkBZBL+36c0PQN3YIejUjmPv6+LBSfNabkuYO8ceF3
	 JHkdugg9h32vTj0r20gkVeymIGd7Tv+vDjbbgObygQIRil1aU+mK8FdO4H3rYKGqOvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046061;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+tZ9WB8Rs4OgofjLKfoILvrRcpb+X9RZqivY5dNRUkM=;
	b=hKMzpBVtv4P+vH2f2Tzk6dm9xveB7aZt8SJdyonxkoIyGRdPCY5Qk3NZNLH5q14xuBsb
	 VZ0RNrcyT9mghJ86wq4DnWL8/YPUxmHYqh/H29bfs/HPE/EfM8tLWupnk6ZqEogu64nUD
	 OJcE0UowoyT8IrKFQqCxeMQ1tFkjWbVqMEQq8JH0KS0FDGt5lQVja9tRBbuxx93F+zpJz
	 RrCp29th+AGck175gp7QGYtogwnD/fu+hYQYgc3NuBmJhumqMJrMGt94hCUYXLUB/Q7AY
	 CqgDoKAcoltfZXwjE937hPSiX4z2j6EBCuaUlZba6Ev51ufbFue8DO2XfOu6pRqA85A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZbVhLQb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C9A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZbVhLQb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8192C1F0089F;
	Sat,  7 Nov 2026 10:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046061;
	bh=+tZ9WB8Rs4OgofjLKfoILvrRcpb+X9RZqivY5dNRUkM=;
	h=From:To:Cc:Subject:Date;
	b=WZbVhLQb7K6p/rRNqtZfjnicb6YxcYiHHMb/p+iOm/R3D/mY1kZbjsMb7fKus+I06
	 ep3aAs3G7yQoihWdsoHZkN/02V4tqSPJfDClwY0ylBH7OArOobwkKTUkOxWdIn9OYO
	 k7SUCGBL8GPKBOJR/BFDqHZuw5qlqLl6TAPBRTp4M0rm1cIhuDtRXkux+M6nG+Fidg
	 UTFYFw/i3IIreOE8c0RIK+VinE404CX7cG9rvbaF60fV3E01U+7XwSb/rupG0eW0iV
	 TEZVMMXZ12qTqmD5lUiWPi+9TxHISVtnQg2xU4EodoComv2is6kZSK5B+bkstKp5BL
	 oTTKbzGD9TfAA==
From: Sasha Levin <sashal@kernel.org>
To: busanna.reddy@oss.qualcomm.com,
	bryan.odonoghue@linaro.org,
	bod@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: iris: Fix power-off ordering to disable power domain after clocks" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:39 -0500
Message-ID: <20261107050739-failed-6.18-9cfae7726a9a@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 9cfae7726a9a9f526e8905dbddde355be2674e3d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050739-failed-6.18-9cfae7726a9a@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9cfae7726a9a9f526e8905dbddde355be2674e3d Mon Sep 17 00:00:00 2001
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 21:24:17 +0530
Subject: [PATCH] media: iris: Fix power-off ordering to disable power domain
 after clocks

In iris_vpu_power_off_hw(), iris_disable_power_domains() was called
before the associated clocks (IRIS_BSE_HW_CLK, IRIS_HW_AHB_CLK,
IRIS_HW_CLK) were disabled and unprepared. This reverses the correct
power-down sequence: with the power domain already removed, the
subsequent clk_disable_unprepare() calls end up operating on
clock-controller hardware that is no longer powered, which can hang
or behave unpredictably.

Reorder the calls so iris_disable_power_domains() runs after all
three clocks are disabled, ensuring clocks are always turned off
while their power domain is still active, and mirroring the reverse
of the power-on sequence.

Fixes: bb8a95aa038e ("media: iris: implement power management")
Cc: stable@vger.kernel.org
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 2ef8004e976e3..c9f5dc851d9f7 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -223,10 +223,10 @@ int iris_vpu_power_off_controller(struct iris_core *core)
 void iris_vpu_power_off_hw(struct iris_core *core)
 {
 	dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], false);
-	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
 	iris_disable_unprepare_clock(core, IRIS_BSE_HW_CLK);
 	iris_disable_unprepare_clock(core, IRIS_HW_AHB_CLK);
 	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
 }
 
 void iris_vpu_power_off(struct iris_core *core)
-- 
2.53.0




