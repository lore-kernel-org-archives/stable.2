Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE344374A06;
	Tue, 15 Sep 2026 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487241; cv=none; b=JkD8Gyj72nw7ZTgPNo5E4RgteHgrYTfso6OGVrU1l71v0wqWYJ7ycteqDfWzQ5X1a5Rb6dXT5Sulk7AedL7j3hESRQkcPR3I836lcSFty5lv/pTWforus5cuFZYFCSF+JhH7b2LsHnTSI+CJykp4PtmcJ9yEnInu6iJpt0LjfIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487241; c=relaxed/simple;
	bh=lmw2Wr3niYluzzMMGX+RXnDV194Ifva91dqoaT7HRWo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nJgoJopW8INFqguI1ZtrJQqSOiqd4BLl4tF2D6+gUzDckPOAS3fmQWmeFbBgPmJ0ZMF+XJaYFCle4FetDgPv6e3iigo/6tvqUmOB5t5qWunlyUgvJjDyjHy9m+qzBVU0qSN8QtsjtEb8YppBe/tkB4pmAeQOypmW36Hc0FiFlas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0FsrkgX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0FsrkgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC591F000FF;
	Tue, 15 Sep 2026 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789487236;
	bh=aiLlbxnXhqaFTV+pX/hYSNLrkBUQLVibK42OiX3IWPI=;
	h=From:Subject:Date:To:Cc;
	b=a0FsrkgXuzby0lYfYvuhSVabhfUxs/ZKSTOF4ujebP0w9MM05sIv/LX/RqsNc+vb1
	 lVBsLFbO1ljHUyDw5JDgwlcZpS/HWE0PgTx6h0aH4KJBToYKkH1aAbnXCmEDeXiBqG
	 7j7mm95pGmebBJsBgFz9NC7Vn0U3Rx6jy8rykkT5/J1zqxIlZ59X6ANmDsc6GJnSNO
	 fSvQxKhrROU/ffv6DwUSHE/kBYO+zQD9A51dnxiLZH7SiwBQ4AkTu6IYhq5Bl+9d/Z
	 w+8pBdYNPJ7mq/J0r7ag8keZkb2JQyC2RmSc5VOaI28ZXYkXdtWWJ2KjWWyyBLvRR+
	 WO3bIrNidlFQg==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 0/2] HID: bpf: add one ssize_t check detected by Sashiko
Date: Tue, 15 Sep 2026 17:46:56 +0200
Message-Id: <20260915-wip-bpf-signed_size-v1-0-6bc8f3d09f5b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTtJgRTQqxhDhjLAuKhNR9BIu
 LsFlm/x/wrKUVjhlq0QeRGVl0/ILxm4ifzIKH0yFKaozDW3+JGAXRhQZfTctyo/xqYkS9bURK6
 BVIbIg3yP6/1xWufuye69r2Db/oQidQN3AAAA
X-Change-ID: 20260915-wip-bpf-signed_size-83a5a507aac8
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487234; l=849;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=lmw2Wr3niYluzzMMGX+RXnDV194Ifva91dqoaT7HRWo=;
 b=veoAOkpLf1LPailI4hOablMH4HTc1PulpemB1L//cP7THFrppczS3aBFq9TvraZOI8GVfPcyR
 KHEDY0zRkXxCFSCV4fOqQuGpq8R0jLPpJ6OvecB6ynpONSQHgXibz0h
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Sashiko detected an existing issue in hid_bpf_hw_request:
if the transport layer returns an error code, hid_bpf_hw_request
returns success, which can confuse the caller.

Add the actual fix and a selftest to ensure this gets properly passed
around.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (2):
      HID: bpf: cast size to ssize_t when checking hid_bpf_hw_request
      selftest/hid: add test for negative return codes for hid_bpf_hw_request

 drivers/hid/bpf/hid_bpf_dispatch.c    |  2 +-
 tools/testing/selftests/hid/hid_bpf.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)
---
base-commit: b6f69097c8271cca30314fd6e4c802f90737bfcc
change-id: 20260915-wip-bpf-signed_size-83a5a507aac8

Best regards,
--  
Benjamin Tissoires <bentiss@kernel.org>

