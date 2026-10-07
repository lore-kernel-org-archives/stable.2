Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354A40B38C
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405772; cv=none; b=Pzdz7oKkDi3lcYvR52DJyqOD1A8WGpnKb2wSTLNL9KnWiPMg0xMaVXCL09Sta+DWGpz66E0/rB/WhIrbFoUQoL/LCzAvS8R/1GekEqdeSDZCrvD+fvECFj6zHm0W3MAZ5LcxE8JNzP4/BmUvO1fI5SGGyqZYCbuXvazqj8+Ht5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405772; c=relaxed/simple;
	bh=TFY9tOSQZG6cW9Xz19R1Fsu14/FrS6A0ND2sm7laFW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utKyJggSUBQKcFDvljj64R9x0XdI9sXsxLumO/7WR1SfkF0MeIrRjJVC3Zp2YyyzjxKZAoeaEDN2kz4Yd57ai9Kf+ZKRlHFTNA5sAJ7+O754laMoBgAkQiIJMkwT00vxO/1JIqoMX8RFhnSlOOnhCTHXIQSdY3stTlnann7DHVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=eBCnAp8c; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="eBCnAp8c"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15756f82e8aso1453421c88.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791405771; x=1792010571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2w44cogeP+44QvieTFJ7kjVK03e1YaQy1nQzOi9xKiA=;
        b=eBCnAp8cjMxB/xqiy0AqummU7qNdD+P0rnAm3da40rx0RbUi1iIYCP8l6jYraUfBT2
         Nx2bWgviVV17/JeoOJt5KT72lpYX91nPb5gheTWq9njdCARPeiDbQdu5JsuIAnNhkMGZ
         /XZzhXiVM+VL+Qv0JgHBqYfea1esAmG6QBQA2MGuDoqXuVlzhAoWbtkrsHEApxfVWCA+
         4fCIck7ErAlXq8gfVUUlsW8n1Vbfhba7zNpttLA87nF/PsCgEqcKZXAmbb2WHZSVYMgR
         HmbJyiVfv71qCkTXT966yn0IXowRKPCh/K3YiuUFTMXwlVf6Kf85xj6tF13bI7trBJU7
         3iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791405771; x=1792010571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2w44cogeP+44QvieTFJ7kjVK03e1YaQy1nQzOi9xKiA=;
        b=lmUGLxZXSJoNu48lyyhjMWE3jPzUBnJI7pkFHb2rxI/foP+/bHf0c9/g38mNwPXXzr
         g51KzkQJxFjBF4+cM4q3ZWufgJ+1W2YNzfwggGBTttgR59bL4lOilaugPGtFQqVctnjF
         /8h6jiBuutYJUp+thhwzZ0lShlUgXcWchCT7+IcBBDbHDDrfVFaNK3X/UdCnCcs9xiq1
         pubZyz+XjXNOHyHsKX7S4uxZK8omk/Eb3wa1l0ycShqVz60YhzsHK9Mb/wgmKsP1vG0s
         7HZcmhS8RCduoxNIW8yDVq5IKoqtnNoF7QGYfnuMGkeeCv5EA9gTmkqMbWdPRnreKd4w
         sc2g==
X-Gm-Message-State: AFuF++mRUnsSsRZw2R8o/Rsr08drgDs8OI/A9y6fLqoSWyBb8dRyu6FN
	MbOuTlFde7HOJY/QCCmgODkKUtpcEBaD9jW7cc0Rw5Tdpl/vYUjhmKDgYahmkCIyre4Gd+dSoET
	HFyVdPTXzMA==
X-Gm-Gg: AYBFou3Ybm84oiU18QjeZex7oqe8wBN1Jlm+qY1O5J2uLQ2SmQHlmKAvjP7SFE/i9A4
	aNBvsZC5EilP2VAjEnWs057TfTpsR0tUBszU+Fv8As8IwPTLSUDRCGXC+SHy8iVbkrwdVdIykt5
	m1ANfEHbpXVigXB7YQCDnVV7YTBRuvy2DBJtVd/Mm1/Bm6zK4Fb/rpuYnKsgqxzQmjHDfdPfnaJ
	HcgDu+HvuOAbuTMxze09PkG/lc9hS+Raurj+xVpq5QmmNsSUIzJxfvjOUGwQmwyZpKfjr9VWFl7
	NjrZEtezc0fU9bHSClP8xXEpk5PTukHP5Qj0OcY8cHnrTvBDsAAsYfL28P4Tn58acE5Y7oASRVu
	Lyd6OuCYCIohF3ZOD0hezQtl9GUHI4iltuXFfRV2rY+djlqrMOMKroThQyi+d7+PQ9s6XUooz7G
	0KpX6mL4E808L206rCnGbHRKpYe+FAcWPjg0fUpDLbudqJDo9T9OWFZw0a03fc8nHx5E94dK5QU
	0Ov2GgQb+TsVubmclS/+grZbiWVl+zJPjKVtSmeku0rmmnUImSXAVJF/jyFyl4gxYBq2IPkquRw
	1tbk+9A=
X-Received: by 2002:a05:7022:b0d4:b0:14c:c588:ac21 with SMTP id a92af1059eb24-1659f86d360mr411370c88.9.1791405770312;
        Wed, 07 Oct 2026 13:42:50 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:7854:1520:fd4f:2a94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16167ef2e54sm7586938c88.10.2026.10.07.13.42.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Oct 2026 13:42:49 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Helge Deller <deller@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Helge Deller <deller@gmx.de>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Georgia Garcia <georgia.garcia@canonical.com>
Subject: [PATCH 6.6.y 0/2] apparmor: backport CVE-2026-45893, CVE-2026-46254
Date: Wed,  7 Oct 2026 16:42:21 -0400
Message-ID: <20261007204226.47033-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and maintainers,

I'm working through the smaller CVE backports still missing from 6.6.y.
These 2 upstream changes belong together for CVE-2026-45893,
CVE-2026-46254. They must be applied in this order because the later change
depends on or completes the earlier one.

The complete series is already present in 6.12.y, 6.18.y, and 7.2.y.
These fixes also affect 6.1.y, which will need a separate backport; this
series is only for 6.6.y.

Could you please consider this series for 6.6.y?

Thanks,
Artem Dinaburg

Series:
  1. AppArmor: Allow apparmor to handle unaligned dfa tables
  2. apparmor: Fix & Optimize table creation from possibly unaligned memory

