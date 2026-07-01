Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D723CFF44;
	Wed,  1 Jul 2026 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897690; cv=none; b=pue6gmjE53lV6O73jz/OVvRBCN66g7U9WeYKPT2kRkT7Ferqr/A8f1h8Pfhu6nKxg+uiiRryxG5pnSvCJgXiIQcN6qv8iSDEzOrKx/SfPoqvIYfvxqfMYXO9WBM9XB7NRkoGDzWu+mH66hIIio8mgukgZ7tWEsJkeB2Ooam91vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897690; c=relaxed/simple;
	bh=Itu0zuJP1QIEVm1n4HhqMKHpUvYrOj/M/IwsB44LALk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lSLCTfOcXWKHaPxWzYQ7CL9SyWJ562gbOy+5+QTeLkDkFf7FWufgpKTC+nC6zvGBLJwPKvpcPTpy98allDmUx/OzLMV4VmcqS4t2N7R1b0yjRxviAXKL/N0Ln39S55TDN0kuwySA4sEWVvnyrPjMHHDLSMw+pcRvUQgf48huCFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HRscMH2h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1mucl8Ro; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HRscMH2h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1mucl8Ro"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782897683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1P4DveztDZLFBBvdim/QuvRX0fea6opwzUnSRtwBTe4=;
	b=HRscMH2hEk4eFGUvQRMinz684fRtcSCcw5V4/tuazqcpITge1r2Snu5ZI+GSEypf/FhoAe
	gsWFPF4w2pOX5O23bj2A2+e14GOFmVSVjTKZvi08LkUmrZbtLxJ1OraI9Wncb9xqZGX+AO
	g6ZDnm5A8e5WjwCjwI4iqVxJtiocghy/ugPMlcC+1sJIClQg452i7tJQtFNf9fjluEklNQ
	uFhQusHiZ2NC6sJS3O+GxMdpc5FLTgu2mH2Kpo63VWowLFvaj7yNbSxWtptLBxH9vELxuf
	1GvndWdqvp1PKehu/TMkzZnrOO+JRJZby0rz8z3odwxwPgH3+y8Ld1TWsxKhuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782897683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1P4DveztDZLFBBvdim/QuvRX0fea6opwzUnSRtwBTe4=;
	b=1mucl8RoLD4zN8QqUTRXyO6tbfnnY213qFutYvpjOm9WGT9iYQgw5j+FSXl6olxZ2KdUPx
	82boq77Um+Bh9kDA==
Subject: [PATCH 0/2] riscv: vdso: Do not use LTO for the vDSO
Date: Wed, 01 Jul 2026 11:21:21 +0200
Message-Id: <20260701-riscv-vdso-lto-v1-0-89db0cd82077@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgNtxA5eRRykphqQVhopgvTuF
 sc3/P+CchZWmLoXMhdRSbHB9h34Y407o2zNQIaccYPBLOoLlk0TnndCWkfvgiFrHUGLrsxBnn8
 4L7V+C4C6dGAAAAA=
X-Change-ID: 20260630-riscv-vdso-lto-2a5c6f021162
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Wende Tan <twd2.me@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 kernel test robot <lkp@intel.com>, stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782897683; l=689;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Itu0zuJP1QIEVm1n4HhqMKHpUvYrOj/M/IwsB44LALk=;
 b=yCwSaWupVhWoA1E000vsVKYKin3V7oT+/pgmoTsgEDzbWh4agJ/uW0jiPhkilk7osRTAnBdLr
 UeBAOy5J1XlAH/cyvV+0ARleJLysbJh/5lo/rEMlwYZhWWTIlGTd5dt
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

With LTO enabled the compiler assumes that the vDSO functions are not
used and optimizes them away completely.

Disable LTO for the vDSO, as these functions are hand-optimized anyways.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      riscv: vdso: Do not use LTO for the vDSO
      riscv: vdso: Simplify cflags remove logic

 arch/riscv/kernel/vdso/Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260630-riscv-vdso-lto-2a5c6f021162

Best regards,
--  
Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>

