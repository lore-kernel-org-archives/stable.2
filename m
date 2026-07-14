Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D023264C1
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040118; cv=none; b=KUlpGQ8lL8mIOtq0HEtgj3E5osdK9vGMGsht4rUnQtthRM/RwHPqTo3GlXC68D7qpeaeMPVBf216uHuzb/mx3l9niec3+CVbKnx4U+448J8RwQGv/OcPtcNELg1lnPgKBqVSSpALef9nQcMCqVgOaQN3bww6slyKbRQPxwetY3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040118; c=relaxed/simple;
	bh=EW5b6SOXr3sMCwmIsVhnNw4T0RgqndsDrATgZmLKg7M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q+OD46JZjBmgPO886Br3YpCAvuskCzc8YPemrBFPDWJhlt0qQ2S1baSS02SOBpKOrx7ZNKoFxswo8megxC5Pv0FjrW9yInKF4AKbX48q9LWBRtH7JMMTcatQ/cpr/cY9Tk3CoHDdOKjVVjQc3bsSruhukXcmgRvDUlvYAOYzHJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l8fNM/WL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l8fNM/WL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08BC1F000E9;
	Tue, 14 Jul 2026 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040099;
	bh=pYmh3mGomz6ZTTiuqX8OduFXJWGL6YNndOk1O28iteU=;
	h=Subject:To:Cc:From:Date;
	b=l8fNM/WLdnf67weKhyPM93jU+psVvA/ZGknNY/5LJomQnfaOGEdAtHZ8plQGaiSH0
	 9GSgLL0IVJH5KmAKDwt4k1elv/fAhHCi1oDKoKMW2F1qOInD+xMW2Kjxr46ZlgdkCh
	 lFl+k0NdviLSEkWvgsZldbjLMeuXtVCyfrg1rkik=
Subject: FAILED: patch "[PATCH] smb: client: harden POSIX SID length parsing" failed to apply to 5.10-stable tree
To: xizh2024@lzu.edu.cn,bird@lzu.edu.cn,n05ec@lzu.edu.cn,stfrench@microsoft.com,tomapufckgml@gmail.com,yifanwucs@gmail.com,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:41:25 +0200
Message-ID: <2026071425-undertone-protozoan-2d33@gregkh>
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
git cherry-pick -x 7ad2bcf2441430bb2e918fb3ef9a90d775a6e422
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071425-undertone-protozoan-2d33@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7ad2bcf2441430bb2e918fb3ef9a90d775a6e422 Mon Sep 17 00:00:00 2001
From: Zihan Xi <xizh2024@lzu.edu.cn>
Date: Sun, 28 Jun 2026 17:19:24 +0800
Subject: [PATCH] smb: client: harden POSIX SID length parsing

posix_info_sid_size() reads sid[1] to obtain the subauthority count,
but its existing boundary check still accepts buffers with only one
remaining byte. Require two bytes before reading sid[1] so all client
paths that reuse the helper reject truncated POSIX SIDs safely.

Fixes: 349e13ad30b4 ("cifs: add smb2 POSIX info level")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index d058584b8f05..77738900e75e 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -5405,7 +5405,7 @@ int posix_info_sid_size(const void *beg, const void *end)
 	size_t subauth;
 	int total;
 
-	if (beg + 1 > end)
+	if (beg + 2 > end)
 		return -1;
 
 	subauth = *(u8 *)(beg+1);

