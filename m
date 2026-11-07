Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047713;
	b=FXScNT2Aazz+vVE6LQFVfwFUcHWKvXxlsAmdbC1fCobf5IQa8YwTGJhbsIYeUl9fiaAI
	 pnuKbURDyYSmH98A4Gk1FO4p12bjDgG42c0+sdeksNOZxrMSTPZ7FOV6h5WRQKb+Quz2b
	 ClzQxQl0EPhZD+ejD6JsvXXX9EeyhXEhg0cds5SfCekM99b8t/X1TZ+zW6onnWydvp18l
	 NXw78sWegTteNhgFDkopMJhfOx4ZheNmTyr8Ys/mYhYYmhq4NSX9aimp/5AfHQqBrXNdo
	 YV4fe9W9mblqLlSsjJW1HHHM4EguM7EvOfZ6o/tM/ctSrl30NuvSeY1t4FaIz7BwNag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047713;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=scOLI2JBXg8tw3Ary4a3mjB6tSHQ+aK+JQNHvCVm49c=;
	b=Cp200EJ+2H1iTuEu2yU9oTF2JYvsNE8eFP+Dde5Mbjo49gljA/aWtp1pbchDq60vh0Xx
	 pgTdwUXzqN2Q4G/9Hp8FU7XZ1m6wNV5h6Dx8gpcW/LpjG6CGC/ROsHtaNe+LjDR0e3DGB
	 CmDTYbouLT7X+o8QlQNeOzOxF+6qLOgFdSdNMF4MtJ6SezJcsSPlPo9KJtgjI+897DX2r
	 2qnClXcxU4oBwe7bEZHEEU2/g+h1NMufIMA/cy9qNvOhpAEzwMCLerwt5JNJLdAfdvpyx
	 /WiXn2tw7KO+0kV8MkOmWmtePF/9fRO+cgYkad2zAAtowaljElqbRz4j4iJmGBECmpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4oEOR7k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB45D606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4oEOR7k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245731F0089F;
	Sat,  7 Nov 2026 10:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047712;
	bh=scOLI2JBXg8tw3Ary4a3mjB6tSHQ+aK+JQNHvCVm49c=;
	h=From:To:Cc:Subject:Date;
	b=j4oEOR7kOFEdOhwxoWZWJcFmaG6VBSltDo4KRuAJOiE8W6X9qOJYnFNs0UFgxWNJ6
	 VQ1d55HYWZbgtvNrrC/dcXREFZyMHA3Yag/xylXB5SiafKK7RltMF78rjdoHvLONkS
	 +MzNR4Q7lTMntf0ggQtETgN3/UWsVoQ1VtAL9rVMelZ3PK+tuBx5V2XsWWJMvQkk6G
	 EPKgqHsNWCNYRGWGO0wFQGTPh8stpKLlWVLMrFZg8lNdFsqF07S0D3XwkiDLoOjgRI
	 7OMmQvJ7tT09y6WA1wTU96cfbV0hEeeMq8fKrQKc3vlxxQKunYgKPV9cPQnHpQ/Mno
	 g9hoCub0GjVlQ==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	lee@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mfd: ab8500: Fix child device leaks on probe failure" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:11 -0500
Message-ID: <20261107053511-failed-6.6-5bf2ae8b131d@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5bf2ae8b131d4ae9c0ed5f7aa02532645f512022
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053511-failed-6.6-5bf2ae8b131d@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5bf2ae8b131d4ae9c0ed5f7aa02532645f512022 Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 24 Sep 2026 22:43:55 +0800
Subject: [PATCH] mfd: ab8500: Fix child device leaks on probe failure

ab8500_probe() registers MFD child devices before completing the
remaining device initialization. If a later MFD registration or sysfs
group creation fails, previously registered child devices are not
removed.

Use devm_mfd_add_devices() so registered MFD child devices are removed
when probe fails.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: cca69b67b3ba ("mfd: Export ab8500 chip id to sysfs")
Fixes: 9c717cf3fa16 ("mfd: ab8500-core: Add device for new RTC version for AB8540 cut2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260924144355.1604369-1-lgs201920130244@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/ab8500-core.c | 44 ++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index ceea1ae34dd89..d5602b2f4a0e8 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1194,39 +1194,41 @@ static int ab8500_probe(struct platform_device *pdev)
 		return ret;
 
 	if (is_ab9540(ab8500))
-		ret = mfd_add_devices(ab8500->dev, 0, ab9540_devs,
-				ARRAY_SIZE(ab9540_devs), NULL,
-				0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab9540_devs,
+					   ARRAY_SIZE(ab9540_devs), NULL,
+					   0, ab8500->domain);
 	else if (is_ab8540(ab8500)) {
-		ret = mfd_add_devices(ab8500->dev, 0, ab8540_devs,
-			      ARRAY_SIZE(ab8540_devs), NULL,
-			      0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab8540_devs,
+					   ARRAY_SIZE(ab8540_devs), NULL,
+					   0, ab8500->domain);
 		if (ret)
 			return ret;
 
 		if (is_ab8540_1p2_or_earlier(ab8500))
-			ret = mfd_add_devices(ab8500->dev, 0, ab8540_cut1_devs,
-			      ARRAY_SIZE(ab8540_cut1_devs), NULL,
-			      0, ab8500->domain);
+			ret = devm_mfd_add_devices(ab8500->dev, 0,
+						   ab8540_cut1_devs,
+						   ARRAY_SIZE(ab8540_cut1_devs),
+						   NULL, 0, ab8500->domain);
 		else /* ab8540 >= cut2 */
-			ret = mfd_add_devices(ab8500->dev, 0, ab8540_cut2_devs,
-			      ARRAY_SIZE(ab8540_cut2_devs), NULL,
-			      0, ab8500->domain);
+			ret = devm_mfd_add_devices(ab8500->dev, 0,
+						   ab8540_cut2_devs,
+						   ARRAY_SIZE(ab8540_cut2_devs),
+						   NULL, 0, ab8500->domain);
 	} else if (is_ab8505(ab8500))
-		ret = mfd_add_devices(ab8500->dev, 0, ab8505_devs,
-			      ARRAY_SIZE(ab8505_devs), NULL,
-			      0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab8505_devs,
+					   ARRAY_SIZE(ab8505_devs), NULL,
+					   0, ab8500->domain);
 	else
-		ret = mfd_add_devices(ab8500->dev, 0, ab8500_devs,
-				ARRAY_SIZE(ab8500_devs), NULL,
-				0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab8500_devs,
+					   ARRAY_SIZE(ab8500_devs), NULL,
+					   0, ab8500->domain);
 	if (ret)
 		return ret;
 
 	/* Add battery management devices */
-	ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
-			      ARRAY_SIZE(ab8500_bm_devs), NULL,
-			      0, ab8500->domain);
+	ret = devm_mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
+				   ARRAY_SIZE(ab8500_bm_devs), NULL,
+				   0, ab8500->domain);
 	if (ret)
 		dev_err(ab8500->dev, "error adding bm devices\n");
 
-- 
2.53.0




