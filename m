Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929163;
	b=ILgfzOtwIsL3BiaQggdl5gXbPaxBIdNK/JlcTfMCYr2ogxQSDCHOsCn+lU6slxLTXEXB
	 F1W0s6sOoCVCGIH9Ca2ZW5dGsAPNiNWuDBDcbubhDHPeM0aCbpkpz4d9hWCr+kItcT1Xd
	 k9izPlhjFrj0698Jxt5wxiQA4stkiG8nwN+0Oj1fCNIT9gjMz6iwh2mzJtpfY5zLX0K59
	 u4juvjv5kisUT0ri39BflixkP3cPAS0vDr26LiiqB9Hg+PwZSroz7oqPNfhixS2zppqHf
	 PSsyB5Ta7w9ymPy3xTEaTLW96QjRqTw+5RpB1InMfmBeX4/lB84jczYnFotrP1bHnyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929163;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JtbH7+auCaVrsMrOZRI5NFONvBjla6W950PrbUlYR88=;
	b=AOPD0oWs9XOgF6nuCYxsqKqsqdJw04XdOMlaEVvg85LpUBZkFb4EInz5C8SHCaRwlvCW
	 H35GTHG6FT8mDJ59jgfaXjc3MKWOtqqDMTRIkwaNRlcecCYj8zK408YSQaO3lzj8vxvLK
	 cX/edvlDWwKThBcMV3WDqcqiNpVl6AgxP17Ukdwb9LYm5rIh+X+fNKc8J8SeB7SJVqikg
	 rlZpfFljbc8sgm6o3JJlt+t73pY1Xp5Y3ANHTTDpLfhxmVK9u4FB2s9v7Rvy8T5QP2U/e
	 ACohN6S1pqpbqO2QdBscWggj1RzRGsSrqFWmGTEAoSi7wWaQqkVQCtMWxfWfVBydcVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/OvtLl8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0846606A32C;
	Tue, 17 Nov 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/OvtLl8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B261F000D0;
	Tue, 17 Nov 2026 15:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929162;
	bh=JtbH7+auCaVrsMrOZRI5NFONvBjla6W950PrbUlYR88=;
	h=From:Subject:Date:To:Cc;
	b=m/OvtLl83JygaZFNY4rbc114qH4Tos2nIqIJ/aSUVT++x2AJngIBe7Bv28c6FEp5b
	 kHptqx7lYeaUgaGxYhQTF1LrPye/50GpPjnXQbBbZR6VkrmItEm0FgIOjLK45H+/51
	 etJg2r4UXluEdpuKGd9JpONmhaZpOZMRcHYIhI7388TQtBhnfP6ruyhqiy+Q5Tjw+U
	 7CYszaFqxfiI0hnd53VVJN2uiH+qctmkE1EpcvhIj2kQjvnJh60CMfqKXLn8hc9rke
	 OgDCbWHjOcJxC5QD0ubYWPWkZ9elawDX0aPDDLODIH6IludQmM83mO5KAZAs4gz6Nr
	 pi3gMYwUixdnw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH net 0/2] net: fix a pidfd leak with a short SO_PEERPIDFD
 optlen
Date: Tue, 17 Nov 2026 16:25:29 +0100
Message-Id: <20261117-work-net-peerpidfd_short_optlen-v1-0-a93f56288501@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw7CIBREf6W5ayHQBT5+xZiGx62gBsiFqknTf
 xd063ImZ+asUJACFjgNKxA+QwkptiB3A1iv4xVZcC3DKEYlpdyzV6I7i1hZRqQc3Oym4hPVKeX
 6wMiOUsuDUFY45aC9ZMI5vL+GM7QdXH5lWcwNbe3fHTO6IDOko/W96hbeaP7fwjsO2/YBfMMPk
 b8AAAA=
X-Change-ID: 20261117-work-net-peerpidfd_short_optlen-91a1806c0d6d
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, netdev@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gUcViYGl+LX6lB1gmntdmHvvYliXKXEdZtb9qX2eE0M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9KWKyipC4fJ7r95PTEhxChRKhKyIDjhoKdmsnbTXx3
 yDdwDOno5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIqjAz/IxafXa6z+tb6wrbX
 cT/C62YGO6vKH3+ec9R+B1fbgq+HvRj+6aaqZDcWeqpY3TPvVl0Uq//t+u7UuV9b5ui9lbfdUmX
 OAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

SO_PEERPIDFD caps optlen at sizeof(int) but never rejects a shorter one.
With an optlen of 0 to 3 getsockopt() still installs a pidfd and copies
only part of the fd number to userspace, or none of it. The caller can't
close an fd it doesn't know about, so the pidfd sticks around until the
process exits.

That's been the case since SO_PEERPIDFD went in for v6.5. When I moved
the code into a helper for SO_PEERPIDFD_THREAD in v7.4-rc1 I kept the
bug, so the new option has it too.

So just fail with EINVAL before we prepare the pidfd. SCM_PIDFD already
does the equivalent and sets MSG_CTRUNC before it allocates anything.
The second patch adds a selftest.

Note that before v7.4 the code still lives inline in sk_getsockopt(). So
the fix won't apply to the stable trees as is but the change there is
the same.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      net: don't leak pidfds through a short SO_PEERPIDFD optlen
      selftests/net: check that a short SO_PEERPIDFD optlen fails

 net/core/sock.c                                 |  6 ++-
 tools/testing/selftests/net/af_unix/scm_pidfd.c | 51 +++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)
---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20261117-work-net-peerpidfd_short_optlen-91a1806c0d6d

