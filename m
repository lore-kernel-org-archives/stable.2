Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592089;
	b=OhNCD+zUlD6n5+8VJ9fWD+dfyDvZ49Q929ReUaMvZLT2coFF1wet5Q6Rd/d0lK5PhmZu
	 4bTFd2IeKrYoeus5Q0m+9M+UdKX28/YG16rzcu+37RuaEz8+dWOhn4aYJX9O57g9b7ix/
	 zzeyHIe3sxPz8Jbo3Ac4sMKAL8RErkon/lZQPpRg8RNW8yUwGdQNdrySEXoqiV8kPGCVO
	 +4lpH0WgLLgZb8Co1j7IP4YHCy5o3Ap8YEJnJTuyc+LAYud8Kx8Op6CREJOEKVID72n6g
	 QPGdCZdriT6XLQS98+T9cWDGYiq+xRN+WE0rPWxeDKeemEIVWEvlKwF0lWMxak3wR8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592089;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=hzCT+beXDKfeA3ZEkGjRcM/Htix7zj/oPWhurAVKY50=;
	b=VTlxj1Wt1b0lvA+fzis5BNEaKj+eXTpzQD35GYfwpv4E5Jctf/QERFMssQumrTTRtFcL
	 pshS6CFNMjnjU4DieLAATk2EyTDPqH7gs1IdC44W9x8VIoRTdIeyaRHXk+UiK1NEo+22I
	 O2GLY77FPUm5Q1FXj+yoAjKzx85trzBl3fcMENIUpmhO1pK5mzeqMAseNb9tuBOo1aNqZ
	 yvmUCW5QZGQ28we1+tr0EytFRZBBVlC5caG+B98I52hdo3LzlEhBg2sbLIwQ4Iqq8fk7A
	 5aDksD+Zgd8vjIta/gWI1Wn98m1qBEymcIxcfocZ5fFhru/TW451xwwg1W3lJuDeLew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=ViFpkLts;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C427F6070F33;
	Fri, 13 Nov 2026 17:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C427F6070F33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=ViFpkLts
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jR4V76Hbnz52SFx;
	Sat, 14 Nov 2026 01:47:59 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592079;
	bh=qF5FUCfG5eoFNK3rM8T3JWqoQ+qpWLphLmw8W1fmByI=;
	h=Date:From:To:Cc:Subject;
	b=ViFpkLtsy54fVaSlQdE7RT8kUX1gaSqBG2TAE0BiLIBxUYBYR9IYpxZ+CXIcSsoAH
	 /5SVqC/4dUjTZEfW4LDs+D7uWv/kPP/ImxWuWb3PKcBzWseEONehHsN/ogkwk2SYjP
	 +/JpH9vSANn+eqZ5f4clgV2QnjZtmjgCCDQYrwgEd6YDZRs8sM2COkuEe/ULDA8Xyj
	 vYYxXxTAJX962WtT/0DVi5WXUE8oe/V2Kl7ZCiGRpngDxFKEzegZg3T6aCgsm81fwc
	 r90gI24PdIAsjkdBd6hr1fy99E2FU1J8fCG1sYTLAsgkmilYZrsojdcHMzl6HDLJ7k
	 ZuqcpneZYnZ4g==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6ADHlo9X060055;
	Sat, 14 Nov 2026 01:47:50 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 01:47:54 +0800 (CST)
X-Zmail-TransId: 2afa6af74d4aaae-2d9dc
X-Mailer: Zmail v1.0
Message-ID: <20261114014754440R7cZjW-DgggyExZ9u5t_q@zte.com.cn>
Date: Sat, 14 Nov 2026 01:47:54 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHY0IDAvNF0gYXRhOiBsaWJhdGEtc2NzaTogZml4IEFUQSBQQVNTLVRIUk9VR0goMzIpIGhhbmRsaW5n?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ADHlo9X060055
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 14 Nov 2026 01:47:59 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF74D4F.000/4jR4V76Hbnz52SFx

ATA PASS-THROUGH(32) still has translation and completion paths that
interpret fields as if the command used a 12- or 16-byte CDB.

Patch 1 checks the reserved bits in byte 10, skips the nonexistent
MULTIPLE_COUNT field, and corrects the invalid-PROTOCOL field pointer.
Patch 2 rejects unsupported service actions with sense data. Patch 3
honors CK_COND and generates SAT sense on completion. Patch 4 corrects
the remaining field pointers, including READ/WRITE LONG count errors.
The four patches can be applied independently.

Changes in v4:
- Patch 1: follow Niklas's correction to validate byte 10 bits 7:5
  with fp=10, leave CONTROL out of the count checks, and retain
  READ/WRITE MULTIPLE support. Correct the comment and description.
  Split the warning after dev, per Damien's nit. Extend the function
  tests to cross CONTROL values and byte-10 reserved bits.
- Patches 2-4: code and commit messages unchanged; retain Damien's
  Reviewed-by tags. Patch 1 needs review again after its behavior change.
Previous version: https://lore.kernel.org/all/20261112220113627e1oAXj5lbAzyI0Xe6Joud@zte.com.cn/

Codex assisted with the review changes, descriptions and validation
scripts. The updated code was function-tested and build-tested.

Shao Mingyin (4):
  ata: libata-scsi: reject reserved bits in 32-byte passthru
  ata: libata-scsi: reject unsupported ATA-32 service actions
  ata: libata-scsi: generate SAT sense data for ATA PASS-THROUGH(32)
  ata: libata-scsi: fix remaining passthru field pointers

 drivers/ata/libata-scsi.c | 70 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 20 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
