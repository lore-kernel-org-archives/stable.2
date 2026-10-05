Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7786A4052A5
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189605; cv=none; b=jcqQQpKMSnaBXRAhvff49yJzOdVHiM5jaCck/7czN0So65S/PnHEikdZR2/3NTgd/UGLumc+Y6CnJseowEVZSQixpm/ia2seZBw1Bt2XQgXaw+CaRZv7pcwq5C93RFKEvSaYEIF4GDxmFY4vRlTlUgb0Q55dNDndR2QpaOkwIA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189605; c=relaxed/simple;
	bh=r/6pOwl97MLKTmRxHjtuMsGdWOocgImvYBtcOgsZc6k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N8Nka+hdLt0lQnZ/S+T1mv7YPnU3TVG+D1ffW4uJ5XsvyDzC1MxliMGlQGjnYBGC7PHn5jQStXbRNbSBBB9CDjaApFpMcEbpMwFrbwkAj+AkCzm9vjqHmDRV1SViV6QZ3LfnUaQGK2H6b1+QIx3eI/g7CCwN5nLAh8Sy8N/JO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hhrF3fMc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hhrF3fMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FFA1F000FF;
	Mon,  5 Oct 2026 08:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791189599;
	bh=fAybc5SUSiwTIX223mnWKRFB2Y732RcpqOQ+vgEPM2c=;
	h=Subject:To:Cc:From:Date;
	b=hhrF3fMc+2Jl2hk+sqJte0U5cbCy8ezxgYKe0HyjI8izEo+RKuP8HNbsO6PEcokHJ
	 x5WZ7v5Qxg9hPIxwYllH4zJ7FpipR9VcSwUQscTHZj1yx5L4boDzeQHdJ18xRU4x/2
	 RbFCt3OkApNWxkDRTN0aJTfuHJBmC/738riGvMpA=
Subject: FAILED: patch "[PATCH] soc: qcom: geni-se: Correct QUP Core ICC vote constants" failed to apply to 5.15-stable tree
To: viken.dadhaniya@oss.qualcomm.com,gregkh@linuxfoundation.org,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:39:49 +0200
Message-ID: <2026100549-acetone-mannish-7172@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1cd9b1be5a9c56fd69e3f555b200a1844f9b873e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100549-acetone-mannish-7172@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1cd9b1be5a9c56fd69e3f555b200a1844f9b873e Mon Sep 17 00:00:00 2001
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 18:56:27 +0530
Subject: [PATCH] soc: qcom: geni-se: Correct QUP Core ICC vote constants

The GENI_TO_CORE ("qup-core") ICC vote selects the QUP Core 2X clock
rate. The CORE_2X_*_MHZ constants are expressed in Bps, but their
values are several orders of magnitude too small. For example, the
50 MHz threshold is represented by 2500 rather than 25000000 Bps.

As a result, clients using these constants can severely under-vote the
QUP Core clock.

Correct the constants to their intended Bps thresholds so that the ICC
provider selects the corresponding QUP Core 2X clock rate. Drop the unused
definitions.

Fixes: 58ffbba6a399 ("soc: qcom: geni: Support for ICC voting")
Cc: stable@kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20260915-correct-icc-bandwidth-vote-constants-v2-1-f78eb611204e@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 29a53bbc0dd4..5f18d281e6a4 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -347,17 +347,12 @@ struct geni_se {
 #define QUP_SE_VERSION_2_5                  0x20050000
 
 /*
- * Define bandwidth thresholds that cause the underlying Core 2X interconnect
- * clock to run at the named frequency. These baseline values are recommended
- * by the hardware team, and are not dynamically scaled with GENI bandwidth
- * beyond basic on/off.
+ * QUP Core 2X clock votes used by GENI clients through the "qup-core" ICC
+ * path. Values are in Bps and must be converted with Bps_to_icc() before
+ * setting avg_bw.
  */
-#define CORE_2X_19_2_MHZ		960
-#define CORE_2X_50_MHZ			2500
-#define CORE_2X_100_MHZ			5000
-#define CORE_2X_150_MHZ			7500
-#define CORE_2X_200_MHZ			10000
-#define CORE_2X_236_MHZ			16383
+#define CORE_2X_19_2_MHZ		9600000
+#define CORE_2X_50_MHZ			25000000
 
 #define GENI_DEFAULT_BW			Bps_to_icc(1000)
 

