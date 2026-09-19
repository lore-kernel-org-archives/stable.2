Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB41225403;
	Sat, 19 Sep 2026 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789847174; cv=none; b=qztftEKc7FTqeluUkbt9Y/TtNVP4j4SO3b4Z/NCNucgyKiCWRw3XViyEvrcJr8U9vjTYGrFlS8CH7UwKe/sNFcrlB9+7XtgUyKA/VuAowOu0TDTh1Fl2jjQtIua8wOvHfIkskOtELKe9G7TYAm2cEsTSX47OtMpmuewZmWPCfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789847174; c=relaxed/simple;
	bh=x1LTUlrEUNNtlYFqPywn8y8jNcQ2XJz905iL7tXgwBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8e8YLDXCBcQ4LqmzW+CZinAxsG50Rg7wZ4ZlvS0WbxwlTzHseyzMXP26YeASneqO7JB5P+TdIemluI+JlBoJgqn59WluUTSvyaqdG3lWl710hApfZ0wH5yjtW05mJFb3iYl/knZq1uxdTtiUv44ovqFnrrAbvUanWMYUl0UTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/tN42Vl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/tN42Vl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1831F00893;
	Sat, 19 Sep 2026 19:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789847172;
	bh=aNfRZN3+/x2Qq1gmA44EPWzscUUsHxzCk0MmsiDXm/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X/tN42VluKXl2zhMODZEZKnmRM8NzkawsDMn0MiGFU9TAtSaaUiaXyB4hLKdpXdk0
	 ELcDz1LP1hlpigzN5J7iA3uxxQb6pKhvQ+TEO7wjgGRVpw8oT9W4O9RWj5zumRilxE
	 IBsPwy6Bex3J4bmBxmbAK0goA0OhSojJLkCDlV03cbEyd7FQSF0IGiHrQrRH/pA56V
	 UaMEPJR6mpTXCTkMagcTWkiw6jTAuiEywY2qQdzmKT45AjRcSm9uhwOPIVGk6aXdQ6
	 H5+myBN/ArzLsKhWZvcoGQY8QcTmhutwbm/wIHD9JdrWuwZrmjxnDuB9onUwBCq2JO
	 4mPNevTYEyYPQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	Xinyang Ge <xinyang@anthropic.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18.y 3/4] mptcp: close race between scheduler and state change
Date: Sat, 19 Sep 2026 21:39:52 +0200
Message-ID: <20260919193948.1927666-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919193948.1927666-6-matttbe@kernel.org>
References: <20260919193948.1927666-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=matttbe@kernel.org; h=from:subject; bh=Mb9RRb/FkSAQ0Q/CdOU3ted97d6gaYbB/C+421X/jVY=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWPeXac7+aZ7Pu9EKf+78Swh4mNq36WSKa9j3648Tq/ x+jplU3dpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzk9BxGhg9ycZdEP2d4MX5R ufnP+mOw1N00nkn9W6fePqSq8qwn7xsjQ7fMi8/vHz6PqljGxPdfQqyW443r/HNVsZbXTrNfFz8 QxAMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 42064de57fb83231fcc89663a94885f228a1ee53 upstream.

The mptcp scheduler may race with subflow sockets state change: data
transmission on the selected socket may fail and a later release could
try to use mss_now reset to 0 for a divide operation.

Address the issue by explicitly checking for the critical scenario.

Fixes: c886d70286bf ("mptcp: do not queue data on closed subflows")
Cc: stable@vger.kernel.org
Reported-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Reported-by: Xinyang Ge <xinyang@anthropic.com>
Closes: https://lore.kernel.org/20260525194828.1137119-1-shardul.b@mpiricsoftware.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260917-net-mptcp-misc-fixes-7-3-rc4-v2-2-0cf5c72667c8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dee5fd3787b5..e600b2efd0df 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1515,7 +1515,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
 {
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
+	if (info->mss_now)
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
 	release_sock(ssk);
 }
 
-- 
2.55.0

