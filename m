Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202623;
	b=NYTyJIoL/nuyl8KNsWMEG5aA/GJx+7m+RFY+qi1MDfFHAK13Duvdc2JL7ITIt4dnwO+5
	 +wy5gmEIf70DZLg35+jI0Z05C/r8xQLu7vD28GSmvPtYNu8bonMH5pFhtKnw9Jg2uHdu0
	 JvHPchfLh1dXGZf+POZCwbKswgX3cvvwBEM3Yhgc5Di6QRfIosI/5Ej72amn0RdiA1K6Y
	 4nv3bPHuu8sGkqjTFy7Of3JH+5UIOq7iHU34lI+gtAk2EscPo3JyyokNZmY00fj6C4bXL
	 qEtDTmxf2m0Th6SNY18tPAy3+wrL2pbXvPr1MrzkA4lMiJNJcO0KBajwR/31hOJK8jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Q/7W+N8PGRXVivlXwZfu/zXqRkAwgaijwKLj6Vh41I0=;
	b=ArmSCpnAb5T5fN6+up10Q0GHuSXNaIeDXKG1yXEsIsbsx6ODSBX89d4y+4Wp8h0/FoNF
	 WXBsuZcybsbd68UM1YvZqWrElnEcX7ER1I9qGuDV6zrCy/pCR5hriyh2h46IVped0G/OT
	 xa6JUDWR9bKxROGk/ZRuC8SNUNKqy0n2KE5/tM0JkogwtZP/yokMBt1y/EY49McwHqDmw
	 vpamKHERoAxEeGEmX0cb+AU/OXyLyE2ZbYgf7Dg5CSt08ofaQuMz3PIXWFPr2GF3oRWH6
	 nw0y3jwp2vg1W3O51+JRwZV68D8L5Rg9UsZCdqE/T1ZErsH/aFA96BVmNUU94n/3TOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=a1UIf7R7;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7F606A6C8
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8B7F606A6C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=a1UIf7R7
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b402824d07so939486a91.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795202622; x=1795807422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q/7W+N8PGRXVivlXwZfu/zXqRkAwgaijwKLj6Vh41I0=;
        b=a1UIf7R7KD/wYIUwBDgkTcz/P1Z86Z3/Ckat+nwKTOtGYAmAzlaOyO3YF8zmNLmiV1
         w/QRe0B0uf+dx2HpWVh67hf8e4emw0O+AM+LrsXLbSbLwVg7JwoflThxDKi/bsZaOf0U
         ptBeFUKuzH5Yo1Nsxnz/sx8Nzhb+u862g3aokXk5pmG+pLti1dA8JxyG4qzpRquX8gj4
         hR6447JnRlVFhUHTUX2AtWrvUuNt3Jt9emzG3YxTUuDT9YZ/ugri3IG+lmBs99omBl86
         XWe6dWPQp17ElVSwXRxbhP62tqpv/tCt4ihGepxTzBaAV+e/3o/P0rDg8YMtqH1zWnq4
         4YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202622; x=1795807422;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q/7W+N8PGRXVivlXwZfu/zXqRkAwgaijwKLj6Vh41I0=;
        b=Pv5bQZzdKt6b+r6d1NQvVavqTeYzhtsoKn78TtCMloaofgkFMshnZDm58Vcg4fl1M+
         yichkNQwFTSvhVxylJWjWL+9csTGA6TVua1pQul00D9/THCSzv/a+VfScpwIuIPMEmwz
         Gk6suSPpZitlHUH8Ud9u67XWss3Gh8Mlc+NXQbsL9mw8oqK918KhQp8UMV+MbfVTaIRV
         5F5L8pLvKw3whJ1IEKW69JnnLV1K5rnvS8BKQcj0AkwubXSI+t3A3RUKrN4Mcua1myoF
         1nTX0wDX1Fq1XMyJwKRxPqPzSZtHwcrtWdIMO6q4zN4Rd4OBkNFsJghfYFw/svnH2Lkc
         mDJg==
X-Gm-Message-State: APuU4Z9odAa29Gj/9XJBbxaukRfTIq0yI3AvEtZdY700zhwJCkcfG3Bp
	np5vXWVGwWNjR+X51Jw2d5ZR2060g63CE2G0EY9hetEBV/SEVWOUcHtqhCv5yDNqsg2PjzyGNhZ
	AcCLb
X-Gm-Gg: AZFdTZf436tE2fKsAJ5H+mXb/iokg4X4QP+veYTeLW7J8Sx03olOewFT++6xb2gTWG/
	rhnL4+iWOJRuHmBblzoRarbg+R6AUzZq4qHllLjSfTTHYT5ZBhbsahDXn2+rGz03ujpNVr+mk7J
	2ghsRCb+MDBOijI51jYNtj0FVo4djHRS9589LE3ObvNN6V/dvEJGQtghlRvX/RAMgBT6D4jJe/0
	gFTt0N7Q+fGNhe2CHpZSeLzh8dbea8O4DpHaWUoukmpnR/AX3okGD2u5t2t+jmG7Lsre0XsyRKE
	O2AB3jPW46dtwIbhM9yQtCnrPHc4bWK+uRipGHbIG3FbkXZjNyg+TSks0P+efHWCqtn1QObjPsm
	NS3a+vsn6ceMiPPfJZmws65Jk3LtU6bb58ZNQJnSmvvqnnbfBA0vd4oY7yeBzVGL1oQRJZiPAMj
	Xoyv8mdyReO0jupPzJwyWQ734QoZVTkwUlmMt0KQ0vNAdR85xu8gb1PWDhOUfoK0NWT9mmH3B/9
	1GoH/Box6FYvjRJM4/IpXex10SFlmrRzP8AF9a3EbGWoeAGZcmJj9UAKLVH5yOurV2LmU6NWOC2
	GIDn46rST3dGo5+MYqdvgdpW6BSYBkpXyBQouvuUtbt4tNPi1imDra/1tqnspe4VHrZU1HZaJ1B
	BEx25x+D//26w8GTFcSSH/iU=
X-Received: by 2002:a17:90b:17cd:b0:3ab:4f1:4f76 with SMTP id 98e67ed59e1d1-3b41c900b24mr3971595a91.24.1795202622295;
        Fri, 20 Nov 2026 11:23:42 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:dd51:675:4b81:7ba])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578d771sm8367651a91.1.2026.11.20.11.23.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 11:23:41 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	rafael@kernel.org
Subject: [6.18.y] Please pick ACPI platform parent lifetime fix
Date: Fri, 20 Nov 2026 14:23:36 -0500
Message-ID: <20261120192336.26131-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,=0D
=0D
Please pick commit a9ba4dd2f18bf3f439d9ef0d8f375f90360ba1bd ("ACPI:=0D
platform: Use acpi_bus_get_primary_device()") for 6.18.y. It fixes=0D
CVE-2026-100072.=0D
=0D
acpi_create_platform_device() looks up the parent's physical device with=0D
acpi_get_first_physical_node(), which does not take a reference, so in=0D
theory that device may be freed while it is still in use. The fix takes=0D
one reference with acpi_bus_get_primary_device() and holds it through=0D
resource inspection and platform-device registration.=0D
=0D
The fix is in 6.6.160, 6.12.114 and 7.2.6, and in mainline since 7.3.=0D
6.18.y received only its prerequisite, upstream commit 72530e1f72b0=0D
("ACPI: bus: Introduce acpi_bus_get_primary_device()"), in 6.18.57; the=0D
fix itself did not apply to 6.18.y at that time. It applies unchanged=0D
since 6.18.60, which picked up the ACPI scan changes f234fdaae1ca,=0D
7617cc05df28 and ab06eb920401 that it depends on for context.=0D
=0D
Compiled drivers/acpi/acpi_platform.o on 6.18.64 from a cumulative=0D
x86_64 tree using allmodconfig. No kernel boot or runtime test was=0D
performed.=0D
=0D
An LLM was used to check applicability and stable-queue history and to=0D
draft this request; I reviewed the result.=0D
=0D
Thanks,=0D
Artem Dinaburg=0D
