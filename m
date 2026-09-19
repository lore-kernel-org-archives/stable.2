Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE82CCC6;
	Sat, 19 Sep 2026 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789849770; cv=none; b=gHA9yLLDh/1y4uvgt/9MegxuyuvoexQoMjyf42QPkafyLJHj6tBfutaEDsqfu++UAJxwV14xuazKIjXKrSH6P81VbcvS4NMi5rx1yhDlfB+vyppS/npmQQkbEKnUeIsrnXfwWd6J1bmnI27bdY/I10WG8nlzNfIQE2ALUWgIS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789849770; c=relaxed/simple;
	bh=nL+UUumm0MLX4tpK98oludYV8hT5z6aR0ALYdH8sKcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g8Ea0He7/TdX2JdSDrSyepSbMTPVxB1zAsqKzpAAkPitk6tw+DeenhQE2I3ogYaMkUZJCpWXuU317douaF4sc3wkabRmQo98EuYReu7WwXpTw3FHXJWmZyyrWb8a3L9EtyzDbj+ItkGzyOm/qhtphCKkpg4w0swg9LpjWWpTfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLH809wF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLH809wF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB4A1F000FF;
	Sat, 19 Sep 2026 20:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789849768;
	bh=Qe1+oBg0bKI2AATIT14qxP73tT0czcD+cr9n0vMiKhs=;
	h=From:To:Cc:Subject:Date;
	b=VLH809wFIXZCc7BbWsBbvuzNJct1SUJAAKyQTi1fgg33jPI1WANxhHP39Ufw1yVVj
	 n/HQ3tc4Ym/SRvO1LljBNsjAlYoCqI0MsqZXbijF/PK5c9JSAzIzX0OgP5c0QgE+2V
	 6WD+8+ZPltx9r1Ochc4SPLFBO5A2GdvqlyxzhhNljuN1iusZEnHSVodcMDsM4om++b
	 A03oIVkEG8wOxIgEbz7BJ2bGubhH6v81Gaz1x/cCZnSgNlSEcTw4d3zFVijpm5vCT/
	 /lugwJ54wM3NbLNd9RFBdZyDO+M00mV3zkTAGxbvKc3IXGK74TWrtolmm61TsCXig3
	 SGXNJnRixSFKg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 5.15.y 0/2] mptcp: fix recent failed backports (20260919)
Date: Sat, 19 Sep 2026 22:29:19 +0200
Message-ID: <20260919202918.2074632-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=597; i=matttbe@kernel.org; h=from:subject; bh=nL+UUumm0MLX4tpK98oludYV8hT5z6aR0ALYdH8sKcE=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWfZh/x5mlOnnJhkS3Jxq+Dn17uuZvvRq+6G2986ZMz mI/4RytjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIncbWBkOD2DXWiZQUiE9NMv 35jFnXKklH1O1kkefvOB9+AFERkdM4b/tVeTQo5ZFFgu0nxfVmmb6F/x5/6ctYtDj8YwT23zef+ aEwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The following patches could not be applied without conflicts in this
tree:

- 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
- 42064de57fb8 ("mptcp: close race between scheduler and state change")

Conflicts (if any) have been resolved, and documented in each patch.

Paolo Abeni (2):
  mptcp: avoid unneeded actions on subflow reset
  mptcp: close race between scheduler and state change

 net/mptcp/protocol.c | 10 ++++++----
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 11 +++++++++++
 3 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.55.0

