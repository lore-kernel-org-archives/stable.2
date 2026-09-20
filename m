Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9DB3EA962;
	Sun, 20 Sep 2026 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789897308; cv=none; b=ngyb+aiVi4D7WWqTiwQochg16nFjpzTO0ruNG+2XTLBQUfeXRoe+no3cs8oFWP3EYR331KNgK6Gva4z3MwJiVfo3dm+JaNXJuWcQsqJqZbo8ZWG8/+6+4m+E9TdaC/ItDbEWiFk8uXPsIeopKQCiH1BPwDOwiOHVDBaNi9yhgb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789897308; c=relaxed/simple;
	bh=uXp0H7XteirnL4+eZcP9BYEzUWF5kbIJMAxeVGcWwgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uu0xiY23LWJmjqZROFSMg4Snir50MIxQrKDPlc9cQLTFjKLCiVMr0mm6imYvL2jeImO9Qzo6FX6uCmvmTWUuKDXDe99H+QkVt7CKlL2LMEQBFEIVALFzx5SOg/rsPmOrqHXoTRYTR8gAjKOBthkEnL57JIraUTw74+pb4mXw5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=go+O/OOS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="go+O/OOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BEB1F000FF;
	Sun, 20 Sep 2026 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789897307;
	bh=ZLtQzsdixH/4zcei5rEvVGXPwB0bJ2/QIZu0lvAnFBA=;
	h=From:To:Cc:Subject:Date;
	b=go+O/OOSTsknoD+rBJFieHsjxFbjE+pchVS8ggFcWzekiTjUWn08gL1cVLGBw9vdT
	 PD+Y1jdWVm5f0p3oMdTN4oC8tv0h9uqa87hlv+loX+yrS4TVYPRyeRgClOdN4D9SNI
	 GuQRnilMCSuWEw4u5iTX9sCFXDf31XZ4TayoDj76StupdhDxG7Qvsw4jQkyh1Ax8wD
	 oXYrXsOiVXP7d+b5i9Q8flsDvqEZaffRbL+RpYklpsXX6WHcZoWKlU38+YnBYkI1dL
	 Md5kvK0baWzxHZbKZmi/VrHrJp8BH/UiB3gPQpeMjbDMJAwQoKmSX0hrufDThJzjuk
	 bN2Lgqk3AA3iA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.12.y v2 0/3] mptcp: fix recent failed backports (20260919)
Date: Sun, 20 Sep 2026 11:41:36 +0200
Message-ID: <20260920094135.2431797-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009; i=matttbe@kernel.org; h=from:subject; bh=uXp0H7XteirnL4+eZcP9BYEzUWF5kbIJMAxeVGcWwgc=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWrwoIXyK5lWFNeFZdRfysN77xcRzR15K12NbuPaDmk dO9VmBmRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESEYxgZjkx0s1fXUj3kPYfH /uoNTflGPe23zuFcZsZ7RW9Pvngyl+E328wJeQtOq+95fcC77Iq/bYjD9/7MD/pl2y5FMsbneL1 nAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The following patches could not be applied without conflicts in this
tree:

- 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
- 42064de57fb8 ("mptcp: close race between scheduler and state change")
- f3ef03357396 ("mptcp: fix bad accounting in __mptcp_subflow_push_pending()")

Conflicts (if any) have been resolved, and documented in each patch.

v2: Drop these two patches that have been already backported to this 
    version, but git didn't complain about that. Instead, resolve a 
    small conflict in patch 1 ("mptcp: avoid unneeded actions on subflow
    reset"): decrement the '__unused' variable.

Paolo Abeni (3):
  mptcp: avoid unneeded actions on subflow reset
  mptcp: close race between scheduler and state change
  mptcp: fix bad accounting in __mptcp_subflow_push_pending()

 net/mptcp/protocol.c | 13 ++++++++-----
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/subflow.c  | 11 +++++++++++
 3 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.55.0

