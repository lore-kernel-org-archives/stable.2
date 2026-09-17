Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D93514775;
	Thu, 17 Sep 2026 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650390; cv=none; b=k+tjXv3FwrpiHYHFRGWqNgHRMS8PMcZIcDTICRjfB68zYCK7fy2/XUCOBxTbI++MWyJNRIIQdmVhAFTJLGo1ttaMTqZ1gt88nLpCBlgjsWaQ6xvJTDTjVK5wxfbwXHVmYRIo3ycZuuUvCqH3pi0r3oRrXHXlMav/W96bQvQ6els=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650390; c=relaxed/simple;
	bh=YvY8L1roEAhWvwCvpso0WcPH5j2XlLAVWe//WqcF0zA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LUwZrJk4OktI3bNmCym2KhgGIbBtDYjc8ILCKbsTiRu+iRsux6KyKdEFYxHkYsaMcnoKuMKz/X76x0YUzhxkJl98UXzhKcllijCCw9lP6cNJC5ooUh4zzYKSQ5WV3MQYaHta0qKuRelUtm7c3CkGAXLi/LrXzGEjhnZwfrIF22o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfKRyw+z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfKRyw+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F071F00899;
	Thu, 17 Sep 2026 13:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650379;
	bh=vc7qfZCRUlMpAR7yCuZ/u0K6XBb5KY58zoxdAw8kDtI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CfKRyw+zBetItN6A0QtrT9RpgGI7mVoCr0j8fRccdMAjj57Q4mORQaRN77Mg/YXiO
	 WiZUP65EF+/N6YPoVnNKv7VbTon903/cvFmKwzqwunxRIpUqjNZsrIvZXts5LxV5iY
	 aD+yQiPn5vsxMF7Pe+Qc78lNPD5SN7O+py9k8YE074jVBFDiYogWI0EtalmMh8DEtz
	 MXmbnG+GRlgbg09ROVO9XXo3P6m0fm15w9o+vxYiu9kSXm/PotH8KETluXHTUE3/5G
	 PIL+yd5hSXt9J92UTe2ifrlgzobpyPviVattXD+UpVj6r22iKc8TkWafaaXUNxLNvQ
	 Bpo5pJSIf1pDA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 17 Sep 2026 15:05:59 +0200
Subject: [PATCH net v2 3/3] mptcp: fix bad accounting in
 __mptcp_subflow_push_pending()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-net-mptcp-misc-fixes-7-3-rc4-v2-3-0cf5c72667c8@kernel.org>
References: <20260917-net-mptcp-misc-fixes-7-3-rc4-v2-0-0cf5c72667c8@kernel.org>
In-Reply-To: <20260917-net-mptcp-misc-fixes-7-3-rc4-v2-0-0cf5c72667c8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SgypPxpJWWqrPzXbB0Ymof8bd1pKOxlUAs4CVycduFE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJWPz0Y4XrtmCa/hIKUjqXjQ441bOJqcXeT3t45x9xto
 d6X2OveUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJEAPYa/Yu/lLKSz+jrnOO3O
 3FIuq5y/4WKvrt2vlW4n76xunLP8GcNfAfnJx5Vbu+98/Z++9amO4swHhRU9czcuUrt6k3mpwCs
 mRgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

If __subflow_push_pending() errors out we should avoid updating the
copied byte counters, to avoid mismatch push call later on.

Fixes: 0fa1b3783a17 ("mptcp: use get_send wrapper")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 577d0134b9ec..e89a69ab927c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1854,7 +1854,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			ret = __subflow_push_pending(sk, ssk, &info);
 			if (ret <= 0)
 				keep_pushing = false;
-			copied += ret;
+			else
+				copied += ret;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {

-- 
2.55.0

