Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B452E0B5C;
	Sat, 19 Sep 2026 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850415; cv=none; b=qVN62+bN/3BcrB2hRNOrnU1tmT5HNcsiS2iOzc54IKe+Hx3HJI+Lvd4BANXvJyR9/fulBYYELj/X5pYrZFYHtSrk5ETwLIzUy/M3o6w67wA8ntdqo89XDIwPYmCuyoaNwSgY/U9GeftxBNhtPtmFCS61zVAjRGP059azc5Pthds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850415; c=relaxed/simple;
	bh=24Rx+PvMrOnSc1yEnwpOMRDYc4azFLQAsgnAZ4i4JCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bzcFvZcoQJdNMqel2zdHAXxEXwZzSCyBYL30wMWRMZ35eSeAuZuaMYXicQIHlRnQXfGC9Kq/JihKc6M3QQOyjLb27V1rEe15CJA8qrQ0QoDMq2fXDsB1jKjj0u36i4kQc3mMdsEfDHSEFMEOdtRQ/6IBp/83oa2xWI/Xcq0DPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ahof8w02; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ahof8w02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9120D1F000FF;
	Sat, 19 Sep 2026 20:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850413;
	bh=Q9+c4GPcfFh1ABxdVLXyawoaSv03b6uyTbgC0fBlQxE=;
	h=From:To:Cc:Subject:Date;
	b=Ahof8w02eSq4LpMU7CdfYv+O5t+tx3ob1PHI9XRR4UrGQnsapHbLxYUu9UCSRk/Hq
	 LJ2EdHYcjRZpSWdEzRse9c8EsOqusJ6XDhdaECsj288H8lxoVRHyNawq6GotlYxcz5
	 VAIzl8851d5LYNcADziwGZLXQieCjKojmv/UZtQRBczdIb4+azyhz+EJkg3NUeaK2d
	 M532lF+AOLNOO6T3VlXlsyhggFp3ef/VAyAsRd3oTgWBBGj7d/0/1/Hu7DinBTXe6n
	 Xtj8iBM6dftmSB2o5JylH7lvih15HXoeM9YejY21VgIL4nqMGo+JQRSM3pU3a5LNmf
	 3GBra7XrOEbLg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 5.10.y 0/3] mptcp: fix recent failed backports (20260919)
Date: Sat, 19 Sep 2026 22:40:03 +0200
Message-ID: <20260919204002.2106015-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=809; i=matttbe@kernel.org; h=from:subject; bh=24Rx+PvMrOnSc1yEnwpOMRDYc4azFLQAsgnAZ4i4JCc=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWfVZOaDulo9W4+WqHev/BUuMwxrbWKV3f8z9zPyh59 73joXFvRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQWijD8s3rTOG+Z2mf21L7W CB+5xYYPJp5PODyvPHBZx4l2aeaqQ4wMl80KTPPWChkYSHBtk7/RZlu/f5p1gCrnZo8VFppeChL MAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The following patches could not be applied without conflicts in this
tree:

- 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
- 42064de57fb8 ("mptcp: close race between scheduler and state change")

I backported the following commit to avoid conflicts:

- ab82e996a1fa ("mptcp: hold mptcp socket before calling tcp_done")

Conflicts (if any) have been resolved, and documented in each patch.

Florian Westphal (1):
  mptcp: hold mptcp socket before calling tcp_done

Paolo Abeni (2):
  mptcp: avoid unneeded actions on subflow reset
  mptcp: close race between scheduler and state change

 net/mptcp/protocol.c | 10 +++++-----
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 18 +++++++++++++++++-
 3 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.55.0

