Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966340;
	b=KrQPMMV996FP3nBROpULh1lJgHvMwRJxTWpHvNUzSNbFk8WO8QKh6OXGrvUcvF30U5Ih
	 L5u5H/4DhP5Av6dpOXiQaYfteyuDrn+iUq2GLf49yhdnGroRT1mfre3Ylf8SZHpUGlAWG
	 Jeeu6nKf/Xcqc00YG9ZkNhXomI4v01sYIlHoLMdi/EcRNreCD3yri/yi1nE5WImLd/yJn
	 eZsSokmUTINhsO6sgOOVGQNcm90ezrY2I3vJU+sAh844Jwv4Ni+kvLDov4mJ4acKYOXrD
	 8gBUO187Ekc6lwoZgkrg/JQcuxjs8rLPbyKZ+7TZl+VG0D0okb4z9Kv7hB70sbnTGcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966340;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JFZOKiemVFn+ZpLaCoT/8XChxYhHMw6NmRWsjDKhJq4=;
	b=2D3iIiYqk2193JhG0wlOsYJNQEUSyVjHR3OY6MmuzuYOuB0hQWbK/+fAQAvJHP2yJ3LL
	 DpnSMdevx0O8UFDF8zcZ9YVbpSuMcFG58w0JvSFJqrXkw4R34j0Gp8Sc1jr/8hPiXwcvz
	 MY4rsPTk61jyLvezUBENc9hf0GlfJG1JkM9GQAH77ZTigJHl6k7614OlxqIseawHBoKgw
	 Lc3NVxUM2aBBEkm8MyPxnI6DS9bqgOU9c9gdmu3wzZKrj0pTdxjQf0d1MrErUW2bXppW7
	 E2IfnzrdR2Nxni/i+q/uKaYIlabq1PoUY2AieFzzwk2zqv980kpNmEDKaazbS7WGyPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UjFWg8DB;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C3606A31C;
	Wed, 18 Nov 2026 01:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 413C3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UjFWg8DB
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMwof62444013;
	Wed, 18 Nov 2026 01:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JFZOKi
	emVFn+ZpLaCoT/8XChxYhHMw6NmRWsjDKhJq4=; b=UjFWg8DBNtOC+K1kTyIgW/
	sIGcZ+EJnU3B3KHPnkgse8zApaknk6NW+8tdKJxrHXcEBmkXYOsiM6yURsJiqyhy
	VNJEIjF0nYEgIBeBGjc7B1IpiTHhgk6H2fbvu4qweclMj3BlMnBJdFIBjOhd1tcc
	xH5OEFqDi6pZcbs5WIJnufa+B1TcVTKoIlpzNQvqnHDgzKPlea8xcoBjign3jpAL
	JWGhHgqWMny/BjIdl281aNlmtjFf2Eidao0rspmtqRqGYjWpUyooHRzCxOyFwCzJ
	yRc5Z7/mx4zAbQYxLaywzytw4ryxfTYci0fDRaePlJRmT0x19BOHWN01FqNHJnMA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vrcrx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:45:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMnwdH030777;
	Wed, 18 Nov 2026 01:45:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067ne2pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:45:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI1jMnT47907174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 01:45:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C80520040;
	Wed, 18 Nov 2026 01:45:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A1C92004B;
	Wed, 18 Nov 2026 01:45:18 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.63.250])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 01:45:18 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jiale Yao <yaojiale02@163.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/eeh: NUL-terminate force recovery input
Date: Wed, 18 Nov 2026 07:15:17 +0530
Message-ID: <179496619893.633156.18174588142349778639.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261029052948.2525048-1-yaojiale02@163.com>
References: <20261029052948.2525048-1-yaojiale02@163.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: XA71WWIYaHG9bzN6-8FSwGfrw5CvZaBD
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afd0336 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=g1nSsVvyxN4glAn0PLQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FgxudGiZkK_28LRDtuavpf7Df0pJ2gc6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX3Q6on4+nHy5R
 kQRg4RKlnxRewOBCIxourj5zUg7dcJEDlwn1WaT9HkbhOxVqvYL/CJsJ8OwI6rJaozhvM9Y9IaG
 evhGsCDgLPtBrW0x1XftDMjHQQTSAi8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX8qkqBRqc3ZWi
 pis4+cVtmJULHZIB/qYdjC+EGOTIgo9Gny/ImuKED59X17wquI/BO/ew4OeWydKCJrt7U4zGp/Z
 Z86DsiV5Xu4Ls0CiW5/wW7HUSWVklrXUN+8JA5geToDWJbzso18gVHCRDBqFpzmBnUCll/sxTcp
 EVm0P+uYxgNz67vLgJDqXm6Xu5dimzVCO5TjxZi1hvIRgk0iiEaKNQSh+7bu4+32P7zKGxacqD9
 5+Ymr8XQMLhG9jWwgoKtQ1bS4nOGPpNx93ezGKFBovFB/lBS8Prz+NfIMwpqMCRqZCqAWZaUUGe
 kh9kPP+DY4NJwKmOat/G+McA7glGUWqezGRLa0TlvxIVie16AJ1diNw430CrAwMHFSLz/zs4Vg5
 HCpMGz81DNvAXxOTvwJDIKWMWNjBx5+FVUEvWsDqYMvdfXc+ZJilhvVjVyVndOPx0Lt9w9/WxTz
 DcT56GzEDfw4VgCZ6eQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180005

On Thu, 29 Oct 2026 13:29:48 +0800, Jiale Yao wrote:
> eeh_force_recover_write() can fill its entire stack buffer from userspace
> and then pass the unterminated data to strncmp() and sscanf(). This can
> make the string helpers read beyond the buffer.
> 
> Reserve the last byte and initialize the buffer so every accepted input is
> NUL-terminated. Propagate copy errors before parsing as well.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/eeh: NUL-terminate force recovery input
      https://git.kernel.org/powerpc/c/f294ebd827e7a2b831b1eef4aaf437f07b2c235e

cheers
