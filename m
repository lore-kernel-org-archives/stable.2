Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510687;
	b=xK9BfNzNSNY6M3xf/35OYYFbUpjfgywR5hAtD9gnX77hICuBhTUBo7kPmeiKD7/bQERe
	 IJJaBxGChp0B1AGhjmQEfzUnGgks6xxjuBrFizVW6FoEZRWQ35UE5s2rxI06TvAwUipNP
	 k8eboz1Ixi5VZd+Yl4WftfegzkeIbEzC4/PwdTfkyeoASFpI79pDb7Y6ERtluua8G2blm
	 VGF/ECJmdGm+/GQJAnQqnhpWzL0tiY81j1fyXtBOD2LveElsgjE+Mj3xNgl1e+Vq+rXQD
	 2OiRak7pffvaUlQFhQ2cqhjCCF3cNOdhAAGJDjgD4EpOWOUvpHQWbTCQhETtyWuZiag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510687;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=kz3H1WEb9yNKE6XhpJrQKFK8Stph0n8pBLLNdkxojT8=;
	b=kYwvzikyqM6nN0MXFBYtCDxwtyUOhku/jxx2klHOvOQlxy+CEIpCqElgm6yBmL+1bpPn
	 a728u5HdwTOmNWGct+hPd303+9GjO3TyvRVck/52aJZCmNzmUQ1O9289RCxKtyDl5JGEA
	 LbitqpIvfWYCvAkhx9lTRz9EbL9oDc50JWWTEprO2ZUvBY0+GKLCHXiDYYi/nA428YK/R
	 JAWHqLpLz0EOgf71AJj4L0LDyJ8Ef8jcpDBntoPciTJ8f5N3fRk1D7I5xjqOXAtquWOzw
	 mJ7rSQUeotwFf4saTBEFu2Kxj0vQBhZ0sO40uL2wmqZpMV9+UnshInWXDvwf8+BlOHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CDuxjTa8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43CE606A334;
	Thu, 12 Nov 2026 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CDuxjTa8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF861F000C4;
	Thu, 12 Nov 2026 19:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510686;
	bh=kz3H1WEb9yNKE6XhpJrQKFK8Stph0n8pBLLNdkxojT8=;
	h=From:Subject:Date:To:Cc;
	b=CDuxjTa8XUkAljnH8ArWvMxUdlt5REi7bunvQQkf9cSIMe3ZoxOuHYKv1OHR+7GjQ
	 BTWAq5PJAmAAnnQY60NtO4tCkKpd6vlPpJXx+uOAO9Xpt+fjjwcZawiEb0Kh8TSAPk
	 0+veSiSgQB+zmcu9n6WGd9xCSJOnIlxNl57v3B/SYCe7CF6fMrZ4fFM7G0TpK06CTU
	 a+/TpTZTVZkkTVYn5TLqeAEnI0ZR4C/DovP2N5u+4alY9XGbFM94x++NYNdhtS8Y9G
	 u+Jz/jef5YfNGPEdcrVLo/8dP1RANZ7xFwq6we8D9YsDG6T/0ljuRhpm8TQk7X2pqk
	 Hq+00yGLUPuwQ==
From: Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 0/2] PCI/PM: Disable bridge D3 on a few devices
Date: Thu, 12 Nov 2026 13:11:15 -0600
Message-Id: <20261112-superm1-kbz-222179-v3-0-f20b5ac06b6d@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBQFr0K6tqb9tgVceQ/jopQPVBRIC0Ql3
 N0CG01YTvLezEQ8OouenKOJOBytt20T4HSIiKl0UyK1eWACDBRnkFA/dOienNbZhwIAj1MqkjS
 RItZ5kTASjp3Dwr5W6fW2sR+yO5p+MS2Lyvq+de+1OvJltwVCYS8wcsqoSblWSmQaJL/U6Bp8H
 FtXkqUwwo+Ds10HBIdUTKIyqIQUf455nr8LEEuPCwEAAA==
X-Change-ID: 20261028-superm1-kbz-222179-4898547adf80
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kerenl.org, 
 linux-kernel@vger.kernel.org, Mario Limonciello <superm1@kernel.org>, 
 Joshua Perry <josh@6bit.com>, stable@vger.kernel.org, 
 Tony Murray <murraytony@gmail.com>
X-Mailer: b4 0.16.0

A few devices have been reported over the past few cycles
to have problems with bridges at D3. This series adds them
to the block list for the feature.  See individual patches
for details.

Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
Changes in v3:
- Switch Zbook to board ID (Sashiko)
- Link to v2: https://patch.msgid.link/20261110-superm1-kbz-222179-v2-0-5605e6ce6454@kernel.org

Changes in v2:
- Pick up tags (Rafael)
- Correct URL in comment (Sashiko)
- Rebase on v7.4-rc2
- Link to v1: https://patch.msgid.link/20261102-superm1-kbz-222179-v1-0-c91a664ba251@kernel.org

---
Mario Limonciello (2):
      PCI/PM: Disable bridge D3 on Lenovo ThinkCentre M90n-1
      PCI/PM: Avoid D3cold for HP Spectre x360 Convertible 15-ch0xx PCIe Ports

 drivers/pci/pci.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261028-superm1-kbz-222179-4898547adf80

Best regards,
--  
Mario Limonciello <superm1@kernel.org>

