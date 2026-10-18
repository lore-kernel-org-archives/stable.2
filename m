Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8288638236E
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792363328; cv=pass; b=GAvef+dcAi/zudIK4lGxBf0KQ4j1nLfEgdbkpi6cDOeAvUFhXIXVSxWa1vKhvaxc8tOg8UnTENVxDj8YOmG3xlBr8b9qcPZdGI2G7i9msbSIPobCpKHUQxwhUza1OQKus6aHX6xRGPkAOAk6ROxskrHxlJcbdmSshblCpDYC3Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792363328; c=relaxed/simple;
	bh=sA78jFowzAjZIyrY72KMyOJ5GxIFW03/6Vjb2E8Yo9I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AGwsTeXeGRgxoGmWtpOdfHYqyVkq5iuPazhYBnpg+3gCe9qnGvKpx/lF/GmDSekXp64qlOz7f9r74gGRYU1Ve6ptqh57q4mvQW6+Zzc/6aESQmYu1s5EKw8VObjiErf5X4UcdlDH6kvGkNHnkzYsfd3BTMGf+oc/YpzN79e9wxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxnWGiTc; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxnWGiTc"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e977109392so5949625ad.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792363327; cv=none;
        d=google.com; s=arc-20260327;
        b=gSWbCnGl/2V/ukiPw4phqRltMK6CiC+gkPrOvo4wAEqP1ZG7PusC+6KA0kWhD8ye6p
         jpT8BEWge0XauxxDGRu6bBZVhjHoNSbpt5cwHaphzLjp3HjfyfmNWaVdrf9aca9zj9+G
         eNZpGhRPL/zXAnA/PdNW99DRIBYUQYcTmbKENsWQhln1gkBiliDyIjS/VnU9iqSjstgx
         lcEWcbBGLof8gvO0sFc4QzZhX+ze07PEfdvH40O+1GgjE/AjLlC/4TluJ4XhDeb3b50t
         6H8Ope6UZJ7bwQphp3ilTEGoT9/hXundkI96F9Rgc4sQHNz2RvALjxOD7yso81wxthU9
         X+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5Fa4oC/q6RcCMAQDGgF7fdd/gfP+j/8A7cYqh74vbRU=;
        fh=5oHC4WiOSM/fqUYKrJukujo3aKAn5Z214snEhsb8580=;
        b=fxQVfDNoewCh7tyDtpXoTFzeZuhY2YfUbGN6dYBMBmTEuzrTfgaDI3LCkGB9cbt+Ch
         I1TFUbp2nXdX/bphvvQ++84DNVRe4EZ514TPTIfLVjaEZwVkFncVFJi+8MeQbGouJTcm
         Bvl+8u1fecvjFay0fboxarvxpat+LWb0m0y02sAz9z6NvY0Y4aOytVKQAaiCAO6/Ndy8
         iA78BnU396tQHwpP5YosRcNq7E3ykc7uGngP5NKKUzIfhpwUjJqBqmE+oDSx/Nfn+sLf
         ue/WaHD/ajULt3sV1O3PyBDWdzTiLgPOxoo75fw+I7XNjfkDi2ga04hSYJQJ+cTzXHG+
         7VUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792363327; x=1792968127; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Fa4oC/q6RcCMAQDGgF7fdd/gfP+j/8A7cYqh74vbRU=;
        b=nxnWGiTcz2MwxtHJApz8WjZIQcEntKdqKi/M58sFAFSnMffHCED2PmZusphTAXMlgE
         vwHCIfcNQmMRn8lnWyDCaG2M+FBzO6qVlt/8qFAD2WXv0NWZEvDHi6jVg7iRf+EXUI5j
         8l9+ZNKDaAw/9KLdJ1hoRuTGA5qvUD0Bld4nNohfSviGxTdukAjqJ+l5oOEhf7XM6Pgv
         cZ7F+U2FPhi8kjdo5+0hI7n2esdVXW1vhdYPJx5GWKlzpjmbkJut5C9VZ2krSGytcCzP
         zwh6Rqxg8R3CZCe+3TQuPEGAVNVYLAurVQhUdQRCbdNy+0ooWj/B2Q7UrNVS554ul72g
         WGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792363327; x=1792968127;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5Fa4oC/q6RcCMAQDGgF7fdd/gfP+j/8A7cYqh74vbRU=;
        b=oeCF8v2ei+QIoAYSUzgSIO1TrUPHVevpzNDIWMvvg9gvXnLSoX4zJ0tTd6bHiDyrSS
         0+QzkO7C32ewY8pLnM0a2Fy3/ZpOB/52xDl7jJWNdVq0eDXTV7PhFB74FrwkcJqrLaeo
         H3l6pEftZjKma5s3IquDarCd08G3RDDJay+P0vd43vVvRWw8t5Vv/rW0568CsWjUSTBl
         aU8uQ1akMz0i5+6CUtfJRi8yBkfEV+1NB6igHLaosXITj/lD/MVLzoeCGyjJcArZd0YN
         RFfv2V3usg+Ztxd/B9Pu/Swr2yIpbjmsicnG/x2W9P67dROMTThYgnhEiyUg9druPP3F
         huDg==
X-Gm-Message-State: AFq9FYJP5Pwc/DZ/8gk7A/Rhc8HHg4mTFxitaqCVHjbjCkRfZ2/1RWMk
	gYbQBBu+on9pTy9ZjwT/W072+3mJocAoqUcfqfiqyKTImBQQGWaI9dTcpiFjJxQtGwfAbQ5kOSO
	7wb9EDPQg4AUVaIi+/GnTiOp819nDEe4Q4uz7lK+hcgGA
X-Gm-Gg: AYBFou3p16nwlGlkDVl7pvtx0vJebs+7T5SuBn7w/dsjM04i5oYIjOry6JyWPPVUs/A
	SwAcYS3RRgud5mHEpzY6+bNEIMDQGwf08Bw+kbn1pHQZ5GN7rft/HPV/7E037w5mzODmZLYzTFb
	QDceJzDSXr2cLQcJl8s/SPogTkNzGr0QkjltiEUfV6TrFXA31xXtx8eD4zKe6W5Z7okLVVljMz3
	NwncWXde9LqqCd3B9nPW/mS91Rli4RfjRGuXSPrirNfwTPgtvBNMVPRY5sDoZMlDsk1piFIPtY4
	QWnLVtGm+SUQjaryWUQOCkPDGJ3ucVcq7wJRgF2c51ddfyHnS0NXlULW8OWR58U=
X-Received: by 2002:a17:903:22c6:b0:2e2:d39f:182f with SMTP id
 d9443c01a7336-2e9a6d2646cmr50216835ad.28.1792363326788; Sun, 18 Oct 2026
 15:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Connor Stevens <ooglie05@gmail.com>
Date: Sun, 18 Oct 2026 23:41:55 +0100
X-Gm-Features: AclHuK8uJqAgzHBOxFyLhpYlx7hixdCrDgjKxkdDek7f0OQznROONPQ0FgMwdBk
Message-ID: <CAF50T1myMs2LSPUsTAPKyJutxzqQihyxbY3=iVGpxenRbnXxKQ@mail.gmail.com>
Subject: [REGRESSION 7.2.11] ASoC: sdw_utils: cs35l56-ot25 DAI not registered,
 no sound card
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, rf@opensource.cirrus.com, broonie@kernel.org, 
	sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Since 7.2.11 the sound card is missing on a Dell XPS 14 DA14260 (Panther
Lake, subsystem 1028:0db9, CS35L57 amps on SoundWire):

  sof_sdw sof_sdw: ASoC: CODEC DAI cs35l56-ot25 not registered

Fedora 7.2.9-200.fc44 works. 7.2.11-200.fc44 is broken. I did not test
7.2.10.

7.2.11 has bf7a3ce1d563 ("ASoC: sdw_utils: Switch CS35L56/57/62/63 to use
OT25 DAI"), but not the upstream commit before it, 86c8360c97f6
("ASoC: cs35l56: Add DAI for SDCA OT25 stream"), which adds that DAI.

I looked into this with help from Claude Opus 5.5 and checked it
myself. I understand you must get lots of AI generated emails
nowadays; I hope this is helpful nonetheless.

#regzbot introduced: bf7a3ce1d563

Thanks,
Connor
